func friendRequests(n int, restrictions [][]int, requests [][]int) []bool {
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

    res := make([]bool, len(requests))
    for i, req := range requests {
        u, v := req[0], req[1]
        pu, pv := find(u), find(v)
        if pu == pv {
            res[i] = true
            continue
        }
        valid := true
        for _, res := range restrictions {
            a, b := res[0], res[1]
            pa, pb := find(a), find(b)
            if (pa == pu && pb == pv) || (pa == pv && pb == pu) {
                valid = false
                break
            }
        }
        if valid {
            parent[pv] = pu
            res[i] = true
        } else {
            res[i] = false
        }
    }
    return res
}