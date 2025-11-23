func minCost(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
    cost := make([][]int, m)
    for i := range cost {
        cost[i] = make([]int, n)
        for j := range cost[i] {
            cost[i][j] = math.MaxInt32
        }
    }
    cost[0][0] = 0
    q := [][]int{{0, 0}}

    for len(q) > 0 {
        cell := q[0]
        q = q[1:]
        x, y := cell[0], cell[1]
        for i, dir := range dirs {
            nx, ny := x+dir[0], y+dir[1]
            if nx < 0 || nx >= m || ny < 0 || ny >= n {
                continue
            }
            newCost := cost[x][y]
            if i+1 != grid[x][y] {
                newCost++
            }
            if newCost < cost[nx][ny] {
                cost[nx][ny] = newCost
                q = append(q, []int{nx, ny})
            }
        }
    }
    return cost[m-1][n-1]
}