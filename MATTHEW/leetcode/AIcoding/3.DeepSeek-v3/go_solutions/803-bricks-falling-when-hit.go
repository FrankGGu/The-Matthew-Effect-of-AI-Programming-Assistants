func hitBricks(grid [][]int, hits [][]int) []int {
    m, n := len(grid), len(grid[0])
    res := make([]int, len(hits))

    for _, hit := range hits {
        x, y := hit[0], hit[1]
        if grid[x][y] == 1 {
            grid[x][y] = 2
        }
    }

    uf := NewUnionFind(m*n + 1)
    root := m * n

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                if i == 0 {
                    uf.Union(i*n+j, root)
                }
                if i > 0 && grid[i-1][j] == 1 {
                    uf.Union(i*n+j, (i-1)*n+j)
                }
                if j > 0 && grid[i][j-1] == 1 {
                    uf.Union(i*n+j, i*n+j-1)
                }
            }
        }
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    for k := len(hits) - 1; k >= 0; k-- {
        x, y := hits[k][0], hits[k][1]
        if grid[x][y] == 2 {
            grid[x][y] = 1
            pre := uf.Size(root)
            if x == 0 {
                uf.Union(x*n+y, root)
            }
            for _, dir := range dirs {
                nx, ny := x+dir[0], y+dir[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 1 {
                    uf.Union(x*n+y, nx*n+ny)
                }
            }
            cur := uf.Size(root)
            res[k] = max(0, cur-pre-1)
        }
    }

    return res
}

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
    if fx != fy {
        if fx < fy {
            fx, fy = fy, fx
        }
        uf.parent[fy] = fx
        uf.size[fx] += uf.size[fy]
    }
}

func (uf *UnionFind) Size(x int) int {
    return uf.size[uf.Find(x)]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}