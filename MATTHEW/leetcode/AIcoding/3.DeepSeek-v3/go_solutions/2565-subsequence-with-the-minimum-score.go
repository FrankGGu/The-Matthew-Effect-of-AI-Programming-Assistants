func minimumScore(nums []int, edges [][]int) int {
    n := len(nums)
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    xor := make([]int, n)
    in := make([]int, n)
    out := make([]int, n)
    time := 0

    var dfs func(u, p int)
    dfs = func(u, p int) {
        in[u] = time
        time++
        xor[u] = nums[u]
        for _, v := range adj[u] {
            if v != p {
                dfs(v, u)
                xor[u] ^= xor[v]
            }
        }
        out[u] = time - 1
    }
    dfs(0, -1)

    total := xor[0]
    res := math.MaxInt32

    for i := 1; i < n; i++ {
        for j := i + 1; j < n; j++ {
            a, b := i, j
            if in[a] > in[b] {
                a, b = b, a
            }
            var x, y, z int
            if in[b] <= out[a] {
                x = xor[b]
                y = xor[a] ^ xor[b]
                z = total ^ xor[a]
            } else {
                x = xor[a]
                y = xor[b]
                z = total ^ xor[a] ^ xor[b]
            }
            maxVal := max(x, max(y, z))
            minVal := min(x, min(y, z))
            res = min(res, maxVal - minVal)
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}