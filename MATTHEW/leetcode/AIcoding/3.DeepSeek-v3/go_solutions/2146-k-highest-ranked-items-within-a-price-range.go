func highestRankedKItems(grid [][]int, pricing []int, start []int, k int) [][]int {
    m, n := len(grid), len(grid[0])
    low, high := pricing[0], pricing[1]
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    queue := [][]int{{start[0], start[1]}}
    visited[start[0]][start[1]] = true
    var candidates [][]int

    for len(queue) > 0 {
        size := len(queue)
        var levelItems [][]int
        for i := 0; i < size; i++ {
            cell := queue[0]
            queue = queue[1:]
            x, y := cell[0], cell[1]
            if grid[x][y] >= low && grid[x][y] <= high {
                levelItems = append(levelItems, []int{x, y, grid[x][y]})
            }
            for _, dir := range directions {
                nx, ny := x+dir[0], y+dir[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != 0 && !visited[nx][ny] {
                    visited[nx][ny] = true
                    queue = append(queue, []int{nx, ny})
                }
            }
        }
        sort.Slice(levelItems, func(i, j int) bool {
            if levelItems[i][2] != levelItems[j][2] {
                return levelItems[i][2] < levelItems[j][2]
            }
            if levelItems[i][0] != levelItems[j][0] {
                return levelItems[i][0] < levelItems[j][0]
            }
            return levelItems[i][1] < levelItems[j][1]
        })
        for _, item := range levelItems {
            candidates = append(candidates, []int{item[0], item[1]})
            if len(candidates) == k {
                return candidates
            }
        }
    }
    return candidates
}