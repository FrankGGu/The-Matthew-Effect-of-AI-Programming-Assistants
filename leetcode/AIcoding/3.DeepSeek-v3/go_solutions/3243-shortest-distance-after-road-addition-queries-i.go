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

func (uf *UnionFind) Find(u int) int {
    if uf.parent[u] != u {
        uf.parent[u] = uf.Find(uf.parent[u])
    }
    return uf.parent[u]
}

func (uf *UnionFind) Union(u, v int) {
    pu, pv := uf.Find(u), uf.Find(v)
    if pu == pv {
        return
    }
    if uf.size[pu] < uf.size[pv] {
        pu, pv = pv, pu
    }
    uf.parent[pv] = pu
    uf.size[pu] += uf.size[pv]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func shortestDistanceAfterRoadAddition(n int, roads [][]int, queries [][]int) []int {
    adj := make([][]int, n)
    for i := range adj {
        adj[i] = make([]int, n)
        for j := range adj[i] {
            adj[i][j] = -1
        }
    }
    for _, road := range roads {
        u, v := road[0], road[1]
        adj[u][v] = 1
        adj[v][u] = 1
    }

    uf := NewUnionFind(n)
    for u := 0; u < n; u++ {
        for v := u + 1; v < n; v++ {
            if adj[u][v] == 1 {
                uf.Union(u, v)
            }
        }
    }

    dist := make([][]int, n)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            if i == j {
                dist[i][j] = 0
            } else {
                dist[i][j] = -1
            }
        }
    }

    for u := 0; u < n; u++ {
        queue := []int{u}
        for len(queue) > 0 {
            curr := queue[0]
            queue = queue[1:]
            for v := 0; v < n; v++ {
                if adj[curr][v] == 1 && dist[u][v] == -1 {
                    dist[u][v] = dist[u][curr] + 1
                    queue = append(queue, v)
                }
            }
        }
    }

    res := make([]int, len(queries))
    for idx, query := range queries {
        x, y := query[0], query[1]
        if uf.Find(x) != uf.Find(y) {
            res[idx] = -1
            continue
        }
        res[idx] = dist[x][y]
    }

    return res
}