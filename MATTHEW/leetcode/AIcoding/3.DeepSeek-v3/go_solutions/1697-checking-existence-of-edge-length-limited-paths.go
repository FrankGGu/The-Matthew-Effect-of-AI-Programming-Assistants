type UnionFind struct {
    parent []int
    rank   []int
}

func NewUnionFind(n int) *UnionFind {
    parent := make([]int, n)
    rank := make([]int, n)
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

func distanceLimitedPathsExist(n int, edgeList [][]int, queries [][]int) []bool {
    m := len(queries)
    for i := range queries {
        queries[i] = append(queries[i], i)
    }
    sort.Slice(queries, func(i, j int) bool {
        return queries[i][2] < queries[j][2]
    })
    sort.Slice(edgeList, func(i, j int) bool {
        return edgeList[i][2] < edgeList[j][2]
    })

    uf := NewUnionFind(n)
    res := make([]bool, m)
    edgeIdx := 0
    for _, query := range queries {
        limit := query[2]
        for edgeIdx < len(edgeList) && edgeList[edgeIdx][2] < limit {
            uf.Union(edgeList[edgeIdx][0], edgeList[edgeIdx][1])
            edgeIdx++
        }
        res[query[3]] = uf.Find(query[0]) == uf.Find(query[1])
    }
    return res
}