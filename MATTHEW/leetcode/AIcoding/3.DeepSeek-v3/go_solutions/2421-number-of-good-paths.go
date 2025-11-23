func numberOfGoodPaths(vals []int, edges [][]int) int {
    n := len(vals)
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

    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    valToNodes := make(map[int][]int)
    for i, val := range vals {
        valToNodes[val] = append(valToNodes[val], i)
    }

    sortedVals := make([]int, 0, len(valToNodes))
    for val := range valToNodes {
        sortedVals = append(sortedVals, val)
    }
    sort.Ints(sortedVals)

    res := 0
    for _, val := range sortedVals {
        nodes := valToNodes[val]
        for _, u := range nodes {
            for _, v := range adj[u] {
                if vals[v] <= val {
                    rootU := find(u)
                    rootV := find(v)
                    if rootU != rootV {
                        parent[rootV] = rootU
                    }
                }
            }
        }
        count := make(map[int]int)
        for _, u := range nodes {
            root := find(u)
            count[root]++
        }
        for _, c := range count {
            res += c * (c + 1) / 2
        }
    }
    return res
}