func isPossibleToTravel(grid [][]int) bool {
    n := len(grid)
    pos := make(map[int][2]int)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            num := grid[i][j]
            pos[num] = [2]int{i, j}
        }
    }

    maxNum := n * n - 1
    for num := 1; num <= maxNum; num++ {
        prev := pos[num-1]
        curr := pos[num]
        dx := abs(prev[0] - curr[0])
        dy := abs(prev[1] - curr[1])
        if (dx == 2 && dy == 1) || (dx == 1 && dy == 2) {
            continue
        } else {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}