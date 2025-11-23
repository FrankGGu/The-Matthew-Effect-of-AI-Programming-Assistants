func conveyorBelt(matrix []string, start []int, end []int) int {
    m, n := len(matrix), len(matrix[0])
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    dirMap := map[byte]int{'^': 0, 'v': 1, '<': 2, '>': 3}
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = -1
        }
    }
    q := [][]int{start}
    dist[start[0]][start[1]] = 0
    for len(q) > 0 {
        cur := q[0]
        q = q[1:]
        i, j := cur[0], cur[1]
        if i == end[0] && j == end[1] {
            return dist[i][j]
        }
        for d, move := range dirs {
            ni, nj := i+move[0], j+move[1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n {
                cost := 0
                if d != dirMap[matrix[i][j]] {
                    cost = 1
                }
                if dist[ni][nj] == -1 || dist[i][j]+cost < dist[ni][nj] {
                    dist[ni][nj] = dist[i][j] + cost
                    if cost == 0 {
                        q = append([][]int{{ni, nj}}, q...)
                    } else {
                        q = append(q, []int{ni, nj})
                    }
                }
            }
        }
    }
    return dist[end[0]][end[1]]
}