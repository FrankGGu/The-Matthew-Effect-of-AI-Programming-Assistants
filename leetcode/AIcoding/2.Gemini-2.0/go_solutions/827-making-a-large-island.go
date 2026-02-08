func largestIsland(grid [][]int) int {
    n := len(grid)
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    areas := make(map[int]int)
    areaIndex := 2
    maxArea := 0

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || i >= n || j < 0 || j >= n || grid[i][j] != 1 || visited[i][j] {
            return 0
        }
        visited[i][j] = true
        area := 1
        area += dfs(i+1, j)
        area += dfs(i-1, j)
        area += dfs(i, j+1)
        area += dfs(i, j-1)
        return area
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 && !visited[i][j] {
                area := dfs(i, j)
                areas[areaIndex] = area
                grid[i][j] = areaIndex
                maxArea = max(maxArea, area)
                areaIndex++
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                adjacentAreas := make(map[int]bool)
                area := 1
                if i > 0 && grid[i-1][j] != 0 {
                    adjacentAreas[grid[i-1][j]] = true
                }
                if i < n-1 && grid[i+1][j] != 0 {
                    adjacentAreas[grid[i+1][j]] = true
                }
                if j > 0 && grid[i][j-1] != 0 {
                    adjacentAreas[grid[i][j-1]] = true
                }
                if j < n-1 && grid[i][j+1] != 0 {
                    adjacentAreas[grid[i][j+1]] = true
                }
                for k := range adjacentAreas {
                    area += areas[k]
                }
                maxArea = max(maxArea, area)
            }
        }
    }

    return maxArea
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}