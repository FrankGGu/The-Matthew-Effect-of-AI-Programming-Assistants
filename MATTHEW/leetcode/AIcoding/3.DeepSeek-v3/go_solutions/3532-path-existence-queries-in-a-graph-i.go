type UnionFind struct {
    parent []int
}

func NewUnionFind(size int) *UnionFind {
    parent := make([]int, size)
    for i := range parent {
        parent[i] = i
    }
    return &UnionFind{parent}
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
        uf.parent[rootX] = rootY
    }
}

func distanceLimitedPathsExist(n int, edgeList [][]int, queries [][]int) []bool {
    uf := NewUnionFind(n)
    queriesWithIndex := make([][]int, len(queries))
    for i := range queries {
        queriesWithIndex[i] = []int{queries[i][0], queries[i][1], queries[i][2], i}
    }
    sort.Slice(queriesWithIndex, func(i, j int) bool {
        return queriesWithIndex[i][2] < queriesWithIndex[j][2]
    })
    sort.Slice(edgeList, func(i, j int) bool {
        return edgeList[i][2] < edgeList[j][2]
    })
    result := make([]bool, len(queries))
    edgeIndex := 0
    for _, query := range queriesWithIndex {
        u, v, limit, index := query[0], query[1], query[2], query[3]
        for edgeIndex < len(edgeList) && edgeList[edgeIndex][2] < limit {
            uf.Union(edgeList[edgeIndex][0], edgeList[edgeIndex][1])
            edgeIndex++
        }
        result[index] = uf.Find(u) == uf.Find(v)
    }
    return result
}