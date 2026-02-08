package main

func maxAreaOfIsland(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }

    var maxArea int

    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 1 {
                area := dfs(grid, i, j)
                if area > maxArea {
                    maxArea = area
                }
            }
        }
    }

    return maxArea
}

func dfs(grid [][]int, i, j int) int {
    if i < 0 || i >= len(grid) || j < 0 || j >= len(grid[0]) || grid[i][j] != 1 {
        return 0
    }

    grid[i][j] = 0 // mark as visited

    return 1 + dfs(grid, i+1, j) + dfs(grid, i-1, j) + dfs(grid, i, j+1) + dfs(grid, i, j-1)
}