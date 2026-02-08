func countPairs(n int, edges [][]int) int {
    parent := make([]int, n)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(u int) int {
        if parent[u] != u {
            parent[u] = find(parent[u])
        }
        return parent[u]
    }

    for _, e := range edges {
        u, v := e[0], e[1]
        pu, pv := find(u), find(v)
        if pu != pv {
            parent[pv] = pu
        }
    }

    size := make(map[int]int)
    for i := 0; i < n; i++ {
        root := find(i)
        size[root]++
    }

    res := 0
    sum := 0
    for _, cnt := range size {
        res += sum * cnt
        sum += cnt
    }
    return res
}