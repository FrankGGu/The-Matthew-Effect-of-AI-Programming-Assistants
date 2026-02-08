import (
	"fmt"
	"strconv"
	"strings"
)

type Cell struct {
	Row       int
	Col       int
	Name      string // e.g., "R1C1"
	RawInput  string
	Value     int
	IsFormula bool
	Formula   *Formula
}

type Formula struct {
	Op   string   // "SUM", "AVG"
	Refs []string // List of cell names, e.g., ["R1C1", "R1C2"]
}

type Spreadsheet struct {
	cells map[string]*Cell // Map cell name to Cell object
	// dependents[sourceCellName][dependentCellName] means dependentCellName uses sourceCellName
	dependents map[string]map[string]struct{}
	// predecessors[dependentCellName][sourceCellName] means dependentCellName uses sourceCellName
	predecessors map[string]map[string]struct{}
}

func NewSpreadsheet() *Spreadsheet {
	return &Spreadsheet{
		cells:        make(map[string]*Cell),
		dependents:   make(map[string]map[string]struct{}),
		predecessors: make(map[string]map[string]struct{}),
	}
}

func (s *Spreadsheet) getOrCreateCell(row, col int) *Cell {
	name := cellName(row, col)
	if cell, ok := s.cells[name]; ok {
		return cell
	}
	cell := &Cell{
		Row:   row,
		Col:   col,
		Name:  name,
		Value: 0,
	}
	s.cells[name] = cell
	return cell
}

func (s *Spreadsheet) getOrCreateCellByName(name string) *Cell {
	if cell, ok := s.cells[name]; ok {
		return cell
	}
	row, col, err := parseCellName(name)
	if err != nil {
		return &Cell{Name: name, Value: 0}
	}
	cell := &Cell{
		Row:   row,
		Col:   col,
		Name:  name,
		Value: 0,
	}
	s.cells[name] = cell
	return cell
}

func cellName(r, c int) string {
	return fmt.Sprintf("R%dC%d", r, c)
}

func parseCellName(name string) (int, int, error) {
	parts := strings.Split(name, "C")
	if len(parts) != 2 {
		return 0, 0, fmt.Errorf("invalid cell name format: %s", name)
	}
	rStr := strings.TrimPrefix(parts[0], "R")
	row, err := strconv.Atoi(rStr)
	if err != nil {
		return 0, 0, fmt.Errorf("invalid row in cell name %s: %w", name, err)
	}
	col, err := strconv.Atoi(parts[1])
	if err != nil {
		return 0, 0, fmt.Errorf("invalid col in cell name %s: %w", name, err)
	}
	return row, col, nil
}

func parseFormula(expr string) (*Formula, error) {
	expr = strings.TrimPrefix(expr, "=")

	parenIdx := strings.Index(expr, "(")
	if parenIdx == -1 {
		return nil, fmt.Errorf("invalid formula format: missing '(' in %s", expr)
	}

	op := expr[:parenIdx]
	argsStr := expr[parenIdx+1 : len(expr)-1]

	var refs []string
	if strings.Contains(argsStr, ":") {
		rangeParts := strings.Split(argsStr, ":")
		if len(rangeParts) != 2 {
			return nil, fmt.Errorf("invalid range format in %s", expr)
		}
		startName, endName := rangeParts[0], rangeParts[1]
		startR, startC, err := parseCellName(startName)
		if err != nil {
			return nil, err
		}
		endR, endC, err := parseCellName(endName)
		if err != nil {
			return nil, err
		}

		minR, maxR := min(startR, endR), max(startR, endR)
		minC, maxC := min(startC, endC), max(startC, endC)

		for r := minR; r <= maxR; r++ {
			for c := minC; c <= maxC; c++ {
				refs = append(refs, cellName(r, c))
			}
		}
	} else {
		startR, startC, err := parseCellName(argsStr)
		if err != nil {
			return nil, err
		}
		refs = append(refs, cellName(startR, startC))
	}

	return &Formula{Op: op, Refs: refs}, nil
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func (s *Spreadsheet) UpdateCell(row int, col int, expression string) {
	cell := s.getOrCreateCell(row, col)

	cellsToRecalculate := s.getTransitiveDependents(cell.Name)
	cellsToRecalculate[cell.Name] = struct{}{}

	oldPredecessors := make(map[string]struct{})
	for predName := range s.predecessors[cell.Name] {
		oldPredecessors[predName] = struct{}{}
	}
	for predName := range oldPredecessors {
		delete(s.dependents[predName], cell.Name)
		if len(s.dependents[predName]) == 0 {
			delete(s.dependents, predName)
		}
	}
	delete(s.predecessors, cell.Name)

	cell.RawInput = expression
	if strings.HasPrefix(expression, "=") {
		cell.IsFormula = true
		formula, err := parseFormula(expression)
		if err != nil {
			cell.Value = 0
			cell.Formula = nil
		} else {
			cell.Formula = formula
			for _, refName := range formula.Refs {
				s.getOrCreateCellByName(refName)
				if _, ok := s.dependents[refName]; !ok {
					s.dependents[refName] = make(map[string]struct{})
				}
				s.dependents[refName][cell.Name] = struct{}{}

				if _, ok := s.predecessors[cell.Name]; !ok {
					s.predecessors[cell.Name] = make(map[string]struct{})
				}
				s.predecessors[cell.Name][refName] = struct{}{}
			}
		}
	} else {
		cell.IsFormula = false
		cell.Formula = nil
		val, err := strconv.Atoi(expression)
		if err != nil {
			cell.Value = 0
		} else {
			cell.Value = val
		}
	}

	s.recalculate(cellsToRecalculate)
}

func (s *Spreadsheet) GetCellValue(row int, col int) int {
	cell := s.getOrCreateCell(row, col)
	return cell.Value
}

func (s *Spreadsheet) getTransitiveDependents(startCellName string) map[string]struct{} {
	visited := make(map[string]struct{})
	queue := []string{startCellName}

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if _, ok := visited[curr]; ok {
			continue
		}
		visited[curr] = struct{}{}

		for dep := range s.dependents[curr] {
			if _, ok := visited[dep]; !ok {
				queue = append(queue, dep)
			}
		}
	}
	delete(visited, startCellName)
	return visited
}

func (s *Spreadsheet) recalculate(affectedCellNames map[string]struct{}) {
	if len(affectedCellNames) == 0 {
		return
	}

	inDegree := make(map[string]int)
	for cellName := range affectedCellNames {
		inDegree[cellName] = 0
	}

	for cellName := range affectedCellNames {
		for predName := range s.predecessors[cellName] {
			if _, ok := affectedCellNames[predName]; ok {
				inDegree[cellName]++
			}
		}
	}

	queue := []string{}
	for cellName := range affectedCellNames {
		if inDegree[cellName] == 0 {
			queue = append(queue, cellName)
		}
	}

	for len(queue) > 0 {
		currName := queue[0]
		queue = queue[1:]

		currCell := s.cells[currName]
		if currCell == nil {
			continue
		}

		if currCell.IsFormula {
			s.calculateFormulaValue(currCell)
		}

		for depName := range s.dependents[currName] {
			if _, ok := affectedCellNames[depName]; ok {
				inDegree[depName]--
				if inDegree[depName] == 0 {
					queue = append(queue, depName)
				}
			}
		}
	}
}

func (s *Spreadsheet) calculateFormulaValue(cell *Cell) {
	if cell.Formula == nil {
		cell.Value = 0
		return
	}

	var sum int
	var count int

	for _, refName := range cell.Formula.Refs {
		refCell := s.getOrCreateCellByName(refName)
		sum += refCell.Value
		count++
	}

	switch cell.Formula.Op {
	case "SUM":
		cell.Value = sum
	case "AVG":
		if count > 0 {
			cell.Value = sum / count
		} else {
			cell.Value = 0
		}
	default:
		cell.Value = 0
	}
}