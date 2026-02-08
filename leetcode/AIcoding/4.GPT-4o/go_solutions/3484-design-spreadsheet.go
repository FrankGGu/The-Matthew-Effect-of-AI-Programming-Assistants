type Spreadsheet struct {
    data map[string]int
}

func Constructor() Spreadsheet {
    return Spreadsheet{data: make(map[string]int)}
}

func (this *Spreadsheet) Set(row int, col int, value int) {
    cell := fmt.Sprintf("%d:%d", row, col)
    this.data[cell] = value
}

func (this *Spreadsheet) Get(row int, col int) int {
    cell := fmt.Sprintf("%d:%d", row, col)
    if val, exists := this.data[cell]; exists {
        return val
    }
    return 0
}

func (this *Spreadsheet) Sum(row int, col int, ranges []string) {
    total := 0
    for _, r := range ranges {
        parts := strings.Split(r, ":")
        startRow, startCol := parseCell(parts[0])
        endRow, endCol := parseCell(parts[1])

        for r := startRow; r <= endRow; r++ {
            for c := startCol; c <= endCol; c++ {
                total += this.Get(r, c)
            }
        }
    }
    this.Set(row, col, total)
}

func parseCell(cell string) (int, int) {
    parts := strings.Split(cell, ":")
    row, _ := strconv.Atoi(parts[0])
    col, _ := strconv.Atoi(parts[1])
    return row, col
}