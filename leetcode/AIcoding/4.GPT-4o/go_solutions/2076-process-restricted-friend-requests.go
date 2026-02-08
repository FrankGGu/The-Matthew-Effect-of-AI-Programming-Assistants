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

func (uf *UnionFind) Union(x int, y int) {
    rootX := uf.Find(x)
    rootY := uf.Find(y)
    if rootX != rootY {
        uf.parent[rootY] = rootX
    }
}

func numRequests(n int, restrictions [][]int, requests [][]int) int {
    uf := NewUnionFind(n)
    validRequests := 0
    for _, req := range requests {
        x, y := req[0], req[1]
        if uf.Find(x) != uf.Find(y) {
            valid := true
            for _, restrict := range restrictions {
                if (uf.Find(restrict[0]) == uf.Find(x) && uf.Find(restrict[1]) == uf.Find(y)) || 
                   (uf.Find(restrict[0]) == uf.Find(y) && uf.Find(restrict[1]) == uf.Find(x)) {
                    valid = false
                    break
                }
            }
            if valid {
                uf.Union(x, y)
                validRequests++
            }
        }
    }
    return validRequests
}

func numFriendRequests(n int, restrictions [][]int, requests [][]int) int {
    return numRequests(n, restrictions, requests)
}