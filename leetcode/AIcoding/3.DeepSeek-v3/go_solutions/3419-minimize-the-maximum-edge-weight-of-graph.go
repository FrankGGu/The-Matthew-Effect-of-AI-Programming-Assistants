import "sort"

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

func (uf *UnionFind) Union(u, v int) bool {
    rootU := uf.Find(u)
    rootV := uf.Find(v)
    if rootU == rootV {
        return false
    }
    if uf.rank[rootU] > uf.rank[rootV] {
        uf.parent[rootV] = rootU
    } else if uf.rank[rootU] < uf.rank[rootV] {
        uf.parent[rootU] = rootV
    } else {
        uf.parent[rootV] = rootU
        uf.rank[rootU]++
    }
    return true
}

func minMaxEdgeWeight(n int, edges [][]int) int {
    sort.Slice(edges, func(i, j int) bool {
        return edges[i][2] < edges[j][2]
    })

    uf := NewUnionFind(n)
    res := 0
    for _, edge := range edges {
        u, v, weight := edge[0], edge[1], edge[2]
        if uf.Union(u, v) {
            res = weight
        }
    }
    return res
}