package main

type Spreadsheet struct {
    cells map[string]*Cell
}

type Cell struct {
    value  string
    deps   map[string]bool
    dependents map[string]bool
}

func Constructor() Spreadsheet {
    return Spreadsheet{
        cells: make(map[string]*Cell),
    }
}

func (s *Spreadsheet) SetCell(row int, col int, value string) {
    key := getCellKey(row, col)
    if cell, exists := s.cells[key]; exists {
        for dep := range cell.deps {
            delete(s.cells[dep].dependents, key)
        }
        for dependent := range cell.dependents {
            delete(s.cells[dependent].deps, key)
        }
    }
    s.cells[key] = &Cell{
        value:      value,
        deps:       make(map[string]bool),
        dependents: make(map[string]bool),
    }
}

func (s *Spreadsheet) GetCell(row int, col int) string {
    key := getCellKey(row, col)
    if cell, exists := s.cells[key]; exists {
        return cell.value
    }
    return ""
}

func (s *Spreadsheet) SetFormula(row int, col int, formula string) {
    key := getCellKey(row, col)
    if cell, exists := s.cells[key]; exists {
        for dep := range cell.deps {
            delete(s.cells[dep].dependents, key)
        }
        for dependent := range cell.dependents {
            delete(s.cells[dependent].deps, key)
        }
    }
    s.cells[key] = &Cell{
        value:      formula,
        deps:       make(map[string]bool),
        dependents: make(map[string]bool),
    }
}

func getCellKey(row int, col int) string {
    return fmt.Sprintf("%d,%d", row, col)
}