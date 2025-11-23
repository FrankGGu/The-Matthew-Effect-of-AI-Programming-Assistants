type NeighborSumService struct {
    grid [][]int
    rows int
    cols int
}

func Constructor(grid [][]int) NeighborSumService {
    rows := len(grid)
    if rows == 0 {
        return NeighborSumService{grid: grid, rows: 0, cols: 0}
    }
    cols := len(grid[0])
    return NeighborSumService{grid: grid, rows: rows, cols: cols}
}

func (this *NeighborSumService) Update(row int, col int, val int) {
    if row < 0 || row >= this.rows || col < 0 || col >= this.cols {
        return
    }
    this.grid[row][col] = val
}

func (this *NeighborSumService) Sum(row int, col int) int {
    if row < 0 || row >= this.rows || col < 0 || col >= this.cols {
        return 0
    }
    sum := 0
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for _, dir := range directions {
        r := row + dir[0]
        c := col + dir[1]
        if r >= 0 && r < this.rows && c >= 0 && c < this.cols {
            sum += this.grid[r][c]
        }
    }
    return sum
}