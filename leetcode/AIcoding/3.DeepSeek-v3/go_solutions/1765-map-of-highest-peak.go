type Pair struct {
    x, y int
}

func highestPeak(isWater [][]int) [][]int {
    m, n := len(isWater), len(isWater[0])
    res := make([][]int, m)
    for i := range res {
        res[i] = make([]int, n)
        for j := range res[i] {
            res[i][j] = -1
        }
    }

    queue := []Pair{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if isWater[i][j] == 1 {
                res[i][j] = 0
                queue = append(queue, Pair{i, j})
            }
        }
    }

    dirs := []Pair{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]
        for _, d := range dirs {
            x, y := curr.x + d.x, curr.y + d.y
            if x >= 0 && x < m && y >= 0 && y < n && res[x][y] == -1 {
                res[x][y] = res[curr.x][curr.y] + 1
                queue = append(queue, Pair{x, y})
            }
        }
    }

    return res
}