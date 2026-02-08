package main

func gridGame(grid [][]int) int {
    n := len(grid)
    top := make([]int, n)
    bottom := make([]int, n)

    for i := 0; i < n; i++ {
        top[i] = grid[0][i]
        bottom[i] = grid[1][i]
    }

    for i := 1; i < n; i++ {
        top[i] += top[i-1]
    }

    for i := n - 2; i >= 0; i-- {
        bottom[i] += bottom[i+1]
    }

    result := math.MaxInt64
    for i := 0; i < n; i++ {
        current := max(top[n-1]-top[i], bottom[0]-bottom[i])
        result = min(result, current)
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}