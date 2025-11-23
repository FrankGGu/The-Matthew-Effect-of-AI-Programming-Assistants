type UnionFind struct {
    parent []int
    rank   []int
}

func NewUnionFind(size int) *UnionFind {
    parent := make([]int, size)
    rank := make([]int, size)
    for i := range parent {
        parent[i] = i
    }
    return &UnionFind{parent, rank}
}

func (uf *UnionFind) Find(u int) int {
    if uf.parent[u] != u {
        uf.parent[u] = uf.Find(uf.parent[u])
    }
    return uf.parent[u]
}

func (uf *UnionFind) Union(u, v int) {
    uRoot := uf.Find(u)
    vRoot := uf.Find(v)
    if uRoot == vRoot {
        return
    }
    if uf.rank[uRoot] > uf.rank[vRoot] {
        uf.parent[vRoot] = uRoot
    } else if uf.rank[uRoot] < uf.rank[vRoot] {
        uf.parent[uRoot] = vRoot
    } else {
        uf.parent[vRoot] = uRoot
        uf.rank[uRoot]++
    }
}

func minEdgeWeightEquilibriumQueries(n int, edges [][]int, queries [][]int) []int {
    adj := make([][][2]int, n)
    for _, edge := range edges {
        u, v, w := edge[0], edge[1], edge[2]
        adj[u] = append(adj[u], [2]int{v, w})
        adj[v] = append(adj[v], [2]int{u, w})
    }

    parent := make([]int, n)
    depth := make([]int, n)
    weight := make([]int, n)
    var dfs func(int, int, int)
    dfs = func(u, p, d int) {
        parent[u] = p
        depth[u] = d
        for _, e := range adj[u] {
            v, w := e[0], e[1]
            if v != p {
                weight[v] = w
                dfs(v, u, d+1)
            }
        }
    }
    dfs(0, -1, 0)

    lca := func(u, v int) int {
        for u != v {
            if depth[u] > depth[v] {
                u = parent[u]
            } else {
                v = parent[v]
            }
        }
        return u
    }

    res := make([]int, len(queries))
    for i, query := range queries {
        u, v := query[0], query[1]
        ancestor := lca(u, v)
        freq := make(map[int]int)
        for u != ancestor {
            freq[weight[u]]++
            u = parent[u]
        }
        for v != ancestor {
            freq[weight[v]]++
            v = parent[v]
        }
        maxFreq := 0
        total := 0
        for _, cnt := range freq {
            if cnt > maxFreq {
                maxFreq = cnt
            }
            total += cnt
        }
        res[i] = total - maxFreq
    }
    return res
}