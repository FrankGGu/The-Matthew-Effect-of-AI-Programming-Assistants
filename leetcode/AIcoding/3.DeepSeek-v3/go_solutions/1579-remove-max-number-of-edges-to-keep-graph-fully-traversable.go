type UnionFind struct {
    parent []int
    rank   []int
}

func NewUnionFind(size int) *UnionFind {
    parent := make([]int, size+1)
    rank := make([]int, size+1)
    for i := range parent {
        parent[i] = i
    }
    return &UnionFind{parent, rank}
}

func (uf *UnionFind) find(u int) int {
    if uf.parent[u] != u {
        uf.parent[u] = uf.find(uf.parent[u])
    }
    return uf.parent[u]
}

func (uf *UnionFind) union(u, v int) bool {
    rootU := uf.find(u)
    rootV := uf.find(v)
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

func maxNumEdgesToRemove(n int, edges [][]int) int {
    alice := NewUnionFind(n)
    bob := NewUnionFind(n)
    res := 0

    for _, edge := range edges {
        if edge[0] == 3 {
            u, v := edge[1], edge[2]
            a := alice.union(u, v)
            b := bob.union(u, v)
            if !a && !b {
                res++
            }
        }
    }

    for _, edge := range edges {
        t, u, v := edge[0], edge[1], edge[2]
        if t == 1 {
            if !alice.union(u, v) {
                res++
            }
        } else if t == 2 {
            if !bob.union(u, v) {
                res++
            }
        }
    }

    rootA := alice.find(1)
    rootB := bob.find(1)
    for i := 2; i <= n; i++ {
        if alice.find(i) != rootA || bob.find(i) != rootB {
            return -1
        }
    }

    return res
}