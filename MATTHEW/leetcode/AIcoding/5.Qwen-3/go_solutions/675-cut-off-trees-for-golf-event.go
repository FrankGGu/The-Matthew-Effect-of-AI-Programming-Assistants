package main

func cutOffTree(terrain [][]int) int {
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    var bfs func(start []int, target []int) int
    bfs = func(start []int, target []int) int {
        m, n := len(terrain), len(terrain[0])
        visited := make([][]bool, m)
        for i := range visited {
            visited[i] = make([]bool, n)
        }
        q := [][]int{start}
        visited[start[0]][start[1]] = true
        steps := 0
        for len(q) > 0 {
            size := len(q)
            for i := 0; i < size; i++ {
                x, y := q[0][0], q[0][1]
                q = q[1:]
                if x == target[0] && y == target[1] {
                    return steps
                }
                for _, d := range dirs {
                    nx, ny := x+d[0], y+d[1]
                    if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && terrain[nx][ny] > 0 {
                        visited[nx][ny] = true
                        q = append(q, []int{nx, ny})
                    }
                }
            }
            steps++
        }
        return -1
    }

    var trees [][]int
    for i := 0; i < len(terrain); i++ {
        for j := 0; j < len(terrain[0]); j++ {
            if terrain[i][j] > 0 {
                trees = append(trees, []int{i, j})
            }
        }
    }

    sort.Slice(trees, func(i, j int) bool {
        return terrain[trees[i][0]][trees[i][1]] < terrain[trees[j][0]][trees[j][1]]
    })

    res := 0
    start := []int{0, 0}
    for _, tree := range trees {
        steps := bfs(start, tree)
        if steps == -1 {
            return -1
        }
        res += steps
        start = tree
    }
    return res
}