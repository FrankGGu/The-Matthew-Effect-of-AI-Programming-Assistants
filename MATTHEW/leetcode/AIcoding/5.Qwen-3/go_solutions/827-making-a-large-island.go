package main

func largestIsland(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }
    n := len(grid)
    id := 0
    area := map[int]int{}
    directions := [][]int{{0, 1}, {1, 0}, {-1, 0}, {0, -1}}

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || i >= n || j < 0 || j >= n || grid[i][j] != 1 {
            return 0
        }
        grid[i][j] = id
        res := 1
        for _, d := range directions {
            res += dfs(i+d[0], j+d[1])
        }
        return res
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                area[id] = dfs(i, j)
                id++
            }
        }
    }

    maxArea := 0
    for _, v := range area {
        if v > maxArea {
            maxArea = v
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                seen := make(map[int]bool)
                currentArea := 1
                for _, d := range directions {
                    ni, nj := i+d[0], j+d[1]
                    if ni >= 0 && ni < n && nj >= 0 && nj < n {
                        pid := grid[ni][nj]
                        if pid != 0 && !seen[pid] {
                            seen[pid] = true
                            currentArea += area[pid]
                        }
                    }
                }
                if currentArea > maxArea {
                    maxArea = currentArea
                }
            }
        }
    }

    return maxArea
}