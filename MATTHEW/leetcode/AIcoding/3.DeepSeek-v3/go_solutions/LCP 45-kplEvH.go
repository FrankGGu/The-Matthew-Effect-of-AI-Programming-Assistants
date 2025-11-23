func bicycleYard(position []int, terrain [][]int, obstacle [][]int) [][]int {
    m, n := len(terrain), len(terrain[0])
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    visited := make(map[[3]int]bool)
    queue := [][3]int{{position[0], position[1], 1}}
    visited[[3]int{position[0], position[1], 1}] = true
    res := make([][]int, 0)
    resMap := make(map[[2]int]bool)

    for len(queue) > 0 {
        cell := queue[0]
        queue = queue[1:]
        x, y, speed := cell[0], cell[1], cell[2]
        if speed == 1 && (x != position[0] || y != position[1]) {
            if !resMap[[2]int{x, y}] {
                res = append(res, []int{x, y})
                resMap[[2]int{x, y}] = true
            }
        }
        for _, dir := range directions {
            nx, ny := x+dir[0], y+dir[1]
            if nx < 0 || nx >= m || ny < 0 || ny >= n {
                continue
            }
            delta := terrain[x][y] - terrain[nx][ny] - obstacle[nx][ny]
            newSpeed := speed + delta
            if newSpeed <= 0 {
                continue
            }
            key := [3]int{nx, ny, newSpeed}
            if !visited[key] {
                visited[key] = true
                queue = append(queue, key)
            }
        }
    }
    sort.Slice(res, func(i, j int) bool {
        if res[i][0] == res[j][0] {
            return res[i][1] < res[j][1]
        }
        return res[i][0] < res[j][0]
    })
    return res
}