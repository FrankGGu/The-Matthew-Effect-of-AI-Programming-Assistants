type UnionFind struct {
    parent []int
}

func NewUnionFind(n int) *UnionFind {
    uf := &UnionFind{parent: make([]int, n)}
    for i := 0; i < n; i++ {
        uf.parent[i] = i
    }
    return uf
}

func (uf *UnionFind) Find(x int) int {
    if uf.parent[x] != x {
        uf.parent[x] = uf.Find(uf.parent[x])
    }
    return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) {
    rootX := uf.Find(x)
    rootY := uf.Find(y)
    if rootX != rootY {
        uf.parent[rootY] = rootX
    }
}

func shortestDistance(n int, roads [][]int, queries [][]int) []int {
    uf := NewUnionFind(n)
    dist := make([][]int, n)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            if i != j {
                dist[i][j] = 1e9
            }
        }
    }

    for _, road := range roads {
        u, v := road[0], road[1]
        uf.Union(u, v)
        dist[u][v] = 1
        dist[v][u] = 1
    }

    for k := 0; k < n; k++ {
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if dist[i][j] > dist[i][k]+dist[k][j] {
                    dist[i][j] = dist[i][k] + dist[k][j]
                }
            }
        }
    }

    result := make([]int, len(queries))

    for i, query := range queries {
        u, v := query[0], query[1]
        if uf.Find(u) != uf.Find(v) {
            result[i] = -1
        } else {
            result[i] = dist[u][v]
        }
    }

    return result
}