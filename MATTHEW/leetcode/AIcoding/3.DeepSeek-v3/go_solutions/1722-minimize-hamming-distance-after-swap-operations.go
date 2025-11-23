func minimumHammingDistance(source []int, target []int, allowedSwaps [][]int) int {
    n := len(source)
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

    for _, swap := range allowedSwaps {
        u, v := swap[0], swap[1]
        pu, pv := find(u), find(v)
        if pu != pv {
            parent[pv] = pu
        }
    }

    groups := make(map[int][]int)
    for i := 0; i < n; i++ {
        root := find(i)
        groups[root] = append(groups[root], i)
    }

    res := 0
    for _, indices := range groups {
        freq := make(map[int]int)
        for _, idx := range indices {
            freq[source[idx]]++
        }
        for _, idx := range indices {
            if freq[target[idx]] > 0 {
                freq[target[idx]]--
            } else {
                res++
            }
        }
    }
    return res
}