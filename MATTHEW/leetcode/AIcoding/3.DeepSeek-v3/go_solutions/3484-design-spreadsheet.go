type Excel struct {
    cells [][]int
    formulas [][][]string
}

func Constructor(height int, width byte) Excel {
    n := int(width - 'A' + 1)
    cells := make([][]int, height)
    for i := range cells {
        cells[i] = make([]int, n)
    }
    formulas := make([][][]string, height)
    for i := range formulas {
        formulas[i] = make([][]string, n)
    }
    return Excel{cells: cells, formulas: formulas}
}

func (this *Excel) Set(row int, column byte, val int) {
    r := row - 1
    c := int(column - 'A')
    this.cells[r][c] = val
    this.formulas[r][c] = nil
}

func (this *Excel) Get(row int, column byte) int {
    r := row - 1
    c := int(column - 'A')
    if this.formulas[r][c] == nil {
        return this.cells[r][c]
    }
    sum := 0
    for _, ref := range this.formulas[r][c] {
        if len(ref) == 2 {
            col := ref[0][0] - 'A'
            row, _ := strconv.Atoi(ref[0][1:])
            sum += this.Get(row, ref[0][0])
        } else {
            startCol := ref[0][0] - 'A'
            startRow, _ := strconv.Atoi(ref[0][1:])
            endCol := ref[1][0] - 'A'
            endRow, _ := strconv.Atoi(ref[1][1:])
            for i := startRow; i <= endRow; i++ {
                for j := startCol; j <= endCol; j++ {
                    sum += this.Get(i, byte(j + 'A'))
                }
            }
        }
    }
    return sum
}

func (this *Excel) Sum(row int, column byte, numbers []string) int {
    r := row - 1
    c := int(column - 'A')
    formula := make([][]string, 0)
    for _, num := range numbers {
        parts := strings.Split(num, ":")
        if len(parts) == 1 {
            formula = append(formula, []string{parts[0]})
        } else {
            formula = append(formula, []string{parts[0], parts[1]})
        }
    }
    this.formulas[r][c] = formula
    return this.Get(row, column)
}