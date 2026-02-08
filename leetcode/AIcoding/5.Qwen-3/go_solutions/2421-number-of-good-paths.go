package main

func numberOfGoodPaths(parents []int, s string) int {
    n := len(s)
    graph := make([][]int, n)
    for i := 0; i < n; i++ {
        if parents[i] != -1 {
            graph[parents[i]] = append(graph[parents[i]], i)
        }
    }

    type node struct {
        val byte
        idx int
    }

    nodes := make([]node, n)
    for i := 0; i < n; i++ {
        nodes[i] = node{s[i], i}
    }

    sort.Slice(nodes, func(i, j int) bool {
        return nodes[i].val < nodes[j].val
    })

    uf := &UnionFind{parent: make([]int, n), rank: make([]int, n)}
    for i := 0; i < n; i++ {
        uf.parent[i] = i
        uf.rank[i] = 1
    }

    res := n

    for i := 0; i < n; i++ {
        current := nodes[i]
        for _, neighbor := range graph[current.idx] {
            if s[neighbor] <= current.val {
                uf.union(current.idx, neighbor)
            }
        }

        count := make(map[byte]int)
        for j := 0; j < n; j++ {
            if uf.find(j) == uf.find(current.idx) {
                count[s[j]]++
            }
        }

        for _, v := range count {
            res += v * (v - 1) / 2
        }
    }

    return res
}

type UnionFind struct {
    parent []int
    rank   []int
}

func (uf *UnionFind) find(x int) int {
    if uf.parent[x] != x {
        uf.parent[x] = uf.find(uf.parent[x])
    }
    return uf.parent[x]
}

func (uf *UnionFind) union(x, y int) {
    rootX := uf.find(x)
    rootY := uf.find(y)
    if rootX == rootY {
        return
    }
    if uf.rank[rootX] < uf.rank[rootY] {
        uf.parent[rootX] = rootY
    } else {
        uf.parent[rootY] = rootX
        if uf.rank[rootX] == uf.rank[rootY] {
            uf.rank[rootX]++
        }
    }
}