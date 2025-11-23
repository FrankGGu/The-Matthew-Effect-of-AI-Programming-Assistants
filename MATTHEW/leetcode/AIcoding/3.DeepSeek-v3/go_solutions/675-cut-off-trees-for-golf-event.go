import (
    "sort"
)

type Tree struct {
    height int
    x, y   int
}

func cutOffTree(forest [][]int) int {
    trees := []Tree{}
    for i := 0; i < len(forest); i++ {
        for j := 0; j < len(forest[i]); j++ {
            if forest[i][j] > 1 {
                trees = append(trees, Tree{forest[i][j], i, j})
            }
        }
    }
    sort.Slice(trees, func(i, j int) bool {
        return trees[i].height < trees[j].height
    })

    res := 0
    x, y := 0, 0
    for _, tree := range trees {
        steps := bfs(forest, x, y, tree.x, tree.y)
        if steps == -1 {
            return -1
        }
        res += steps
        x, y = tree.x, tree.y
    }
    return res
}

func bfs(forest [][]int, sx, sy, tx, ty int) int {
    if sx == tx && sy == ty {
        return 0
    }
    m, n := len(forest), len(forest[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    queue := [][]int{{sx, sy}}
    visited[sx][sy] = true
    steps := 0
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(queue) > 0 {
        size := len(queue)
        steps++
        for i := 0; i < size; i++ {
            curr := queue[0]
            queue = queue[1:]
            for _, dir := range dirs {
                nx := curr[0] + dir[0]
                ny := curr[1] + dir[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && forest[nx][ny] != 0 {
                    if nx == tx && ny == ty {
                        return steps
                    }
                    visited[nx][ny] = true
                    queue = append(queue, []int{nx, ny})
                }
            }
        }
    }
    return -1
}