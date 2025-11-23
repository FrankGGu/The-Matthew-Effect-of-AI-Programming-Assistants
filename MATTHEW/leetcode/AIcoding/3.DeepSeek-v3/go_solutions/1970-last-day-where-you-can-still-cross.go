type UnionFind struct {
    parent []int
    size   []int
}

func NewUnionFind(n int) *UnionFind {
    parent := make([]int, n)
    size := make([]int, n)
    for i := range parent {
        parent[i] = i
        size[i] = 1
    }
    return &UnionFind{parent, size}
}

func (uf *UnionFind) Find(x int) int {
    if uf.parent[x] != x {
        uf.parent[x] = uf.Find(uf.parent[x])
    }
    return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) {
    fx, fy := uf.Find(x), uf.Find(y)
    if fx == fy {
        return
    }
    if uf.size[fx] < uf.size[fy] {
        fx, fy = fy, fx
    }
    uf.parent[fy] = fx
    uf.size[fx] += uf.size[fy]
}

func latestDayToCross(row int, col int, cells [][]int) int {
    grid := make([][]int, row+2)
    for i := range grid {
        grid[i] = make([]int, col+2)
    }

    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    uf := NewUnionFind(row*col + 2)
    top, bottom := row*col, row*col+1

    for day := len(cells) - 1; day >= 0; day-- {
        r, c := cells[day][0], cells[day][1]
        grid[r][c] = 1
        pos := (r-1)*col + (c - 1)

        if r == 1 {
            uf.Union(pos, top)
        }
        if r == row {
            uf.Union(pos, bottom)
        }

        for _, dir := range directions {
            nr, nc := r+dir[0], c+dir[1]
            if nr >= 1 && nr <= row && nc >= 1 && nc <= col && grid[nr][nc] == 1 {
                npos := (nr-1)*col + (nc - 1)
                uf.Union(pos, npos)
            }
        }

        if uf.Find(top) == uf.Find(bottom) {
            return day
        }
    }
    return 0
}