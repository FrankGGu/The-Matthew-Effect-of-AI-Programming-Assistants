func containVirus(isInfected [][]int) int {
    m, n := len(isInfected), len(isInfected[0])
    res := 0

    for {
        regions := make([][]int, 0)
        frontiers := make([][]int, 0)
        walls := make([]int, 0)
        visited := make([][]bool, m)
        for i := range visited {
            visited[i] = make([]bool, n)
        }

        for i := 0; i < m; i++ {
            for j := 0; j < n; j++ {
                if isInfected[i][j] == 1 && !visited[i][j] {
                    region := make([]int, 0)
                    frontier := make([]int, 0)
                    wall := 0
                    dfs(isInfected, visited, i, j, &region, &frontier, &wall)
                    regions = append(regions, region)
                    frontiers = append(frontiers, frontier)
                    walls = append(walls, wall)
                }
            }
        }

        if len(regions) == 0 {
            break
        }

        maxIndex := 0
        for i := 0; i < len(frontiers); i++ {
            if len(frontiers[i]) > len(frontiers[maxIndex]) {
                maxIndex = i
            }
        }

        res += walls[maxIndex]

        for i := 0; i < len(regions); i++ {
            if i == maxIndex {
                for _, pos := range regions[i] {
                    x, y := pos/n, pos%n
                    isInfected[x][y] = -1
                }
            } else {
                for _, pos := range frontiers[i] {
                    x, y := pos/n, pos%n
                    isInfected[x][y] = 1
                }
            }
        }
    }

    return res
}

func dfs(grid [][]int, visited [][]bool, i, j int, region, frontier *[]int, wall *int) {
    m, n := len(grid), len(grid[0])
    if i < 0 || i >= m || j < 0 || j >= n {
        return
    }
    if visited[i][j] {
        return
    }
    if grid[i][j] == 1 {
        visited[i][j] = true
        *region = append(*region, i*n+j)
        dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
        for _, dir := range dirs {
            ni, nj := i+dir[0], j+dir[1]
            dfs(grid, visited, ni, nj, region, frontier, wall)
        }
    } else if grid[i][j] == 0 {
        *wall++
        *frontier = append(*frontier, i*n+j)
    }
}