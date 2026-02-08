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

func pathExist(n int, edges [][]int, source int, destination int) bool {
    uf := NewUnionFind(n)
    for _, edge := range edges {
        uf.Union(edge[0], edge[1])
    }
    return uf.Find(source) == uf.Find(destination)
}

func PathExistQueries(n int, edges [][]int, queries [][]int) []bool {
    result := make([]bool, len(queries))
    for i, query := range queries {
        result[i] = pathExist(n, edges, query[0], query[1])
    }
    return result
}