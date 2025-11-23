package main

func minimumMoves(grid [][]int) int {
    var stones []int
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] > 1 {
                for k := 1; k < grid[i][j]; k++ {
                    stones = append(stones, i*len(grid[0])+j)
                }
            }
        }
    }
    var empty []int
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 0 {
                empty = append(empty, i*len(grid[0])+j)
            }
        }
    }
    n := len(stones)
    if n == 0 {
        return 0
    }
    res := 0
    for i := 0; i < n; i++ {
        minDist := 1 << 30
        idx := -1
        for j := 0; j < len(empty); j++ {
            dist := abs((stones[i]/len(grid[0]))-(empty[j]/len(grid[0]))) + abs((stones[i]%len(grid[0]))-(empty[j]%len(grid[0])))
            if dist < minDist {
                minDist = dist
                idx = j
            }
        }
        res += minDist
        empty = append(empty[:idx], empty[idx+1:]...)
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}