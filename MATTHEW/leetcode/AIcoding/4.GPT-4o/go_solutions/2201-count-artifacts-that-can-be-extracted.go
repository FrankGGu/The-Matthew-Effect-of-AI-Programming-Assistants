func countArtifacts(n int, artifacts [][]int) int {
    uf := NewUnionFind(n)
    for _, artifact := range artifacts {
        uf.Union(artifact[0], artifact[1])
    }
    return uf.Count()
}

type UnionFind struct {
    parent []int
    rank   []int
    count  int
}

func NewUnionFind(size int) *UnionFind {
    uf := &UnionFind{
        parent: make([]int, size),
        rank:   make([]int, size),
        count:  size,
    }
    for i := 0; i < size; i++ {
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

func (uf *UnionFind) Union(x int, y int) {
    rootX := uf.Find(x)
    rootY := uf.Find(y)
    if rootX != rootY {
        if uf.rank[rootX] > uf.rank[rootY] {
            uf.parent[rootY] = rootX
        } else if uf.rank[rootX] < uf.rank[rootY] {
            uf.parent[rootX] = rootY
        } else {
            uf.parent[rootY] = rootX
            uf.rank[rootX]++
        }
        uf.count--
    }
}

func (uf *UnionFind) Count() int {
    return uf.count
}