type UnionFind struct {
    parent []int
    size   []int
}

func NewUnionFind(n int) *UnionFind {
    parent := make([]int, n+1)
    size := make([]int, n+1)
    for i := 1; i <= n; i++ {
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
    rootX := uf.Find(x)
    rootY := uf.Find(y)
    if rootX == rootY {
        return
    }
    if uf.size[rootX] < uf.size[rootY] {
        rootX, rootY = rootY, rootX
    }
    uf.parent[rootY] = rootX
    uf.size[rootX] += uf.size[rootY]
}

func areConnected(n int, threshold int, queries [][]int) []bool {
    uf := NewUnionFind(n)
    for z := threshold + 1; z <= n; z++ {
        for multiple := z * 2; multiple <= n; multiple += z {
            uf.Union(z, multiple)
        }
    }
    result := make([]bool, len(queries))
    for i, query := range queries {
        x, y := query[0], query[1]
        result[i] = uf.Find(x) == uf.Find(y)
    }
    return result
}