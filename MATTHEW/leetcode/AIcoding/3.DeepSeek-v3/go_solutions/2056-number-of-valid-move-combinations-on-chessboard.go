func countCombinations(pieces []string, positions [][]int) int {
    n := len(pieces)
    dirs := make([][][]int, n)
    for i := 0; i < n; i++ {
        dirs[i] = getDirs(pieces[i])
    }
    pos := make([]int, n)
    for i := 0; i < n; i++ {
        pos[i] = (positions[i][0]-1)*8 + (positions[i][1]-1)
    }
    res := 0
    var dfs func(int)
    dfs = func(idx int) {
        if idx == n {
            res++
            return
        }
        x, y := pos[idx]/8, pos[idx]%8
        for _, dir := range dirs[idx] {
            dx, dy := dir[0], dir[1]
            nx, ny := x, y
            for step := 0; ; step++ {
                nx += dx
                ny += dy
                if nx < 0 || nx >= 8 || ny < 0 || ny >= 8 {
                    break
                }
                newPos := nx*8 + ny
                valid := true
                for i := 0; i < idx; i++ {
                    if pos[i] == newPos {
                        valid = false
                        break
                    }
                }
                if !valid {
                    break
                }
                pos[idx] = newPos
                dfs(idx + 1)
            }
            pos[idx] = x*8 + y
        }
        dfs(idx + 1)
    }
    dfs(0)
    return res
}

func getDirs(piece string) [][]int {
    switch piece {
    case "rook":
        return [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    case "bishop":
        return [][]int{{1, 1}, {1, -1}, {-1, 1}, {-1, -1}}
    case "queen":
        return [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}}
    }
    return nil
}