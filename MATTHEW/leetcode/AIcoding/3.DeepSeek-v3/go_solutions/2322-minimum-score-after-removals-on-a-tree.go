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

    var dfs func(u, parent int)
    dfs = func(u, parent int) {
        in[u] = time
        time++
        xor[u] = nums[u]
        for _, v := range adj[u] {
            if v != parent {
                dfs(v, u)
                xor[u] ^= xor[v]
            }
        }
        out[u] = time - 1
    }
    dfs(0, -1)

    res := math.MaxInt32
    for i := 1; i < n; i++ {
        for j := i + 1; j < n; j++ {
            var a, b, c int
            if in[i] < in[j] && out[j] <= out[i] {
                a = xor[j]
                b = xor[i] ^ xor[j]
                c = xor[0] ^ xor[i]
            } else if in[j] < in[i] && out[i] <= out[j] {
                a = xor[i]
                b = xor[j] ^ xor[i]
                c = xor[0] ^ xor[j]
            } else {
                a = xor[i]
                b = xor[j]
                c = xor[0] ^ xor[i] ^ xor[j]
            }
            maxVal := max(a, max(b, c))
            minVal := min(a, min(b, c))
            res = min(res, maxVal-minVal)
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