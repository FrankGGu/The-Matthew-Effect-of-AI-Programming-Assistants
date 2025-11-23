func countPalindromePaths(parent []int, s string) int64 {
    n := len(parent)
    adj := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parent[i]
        adj[p] = append(adj[p], i)
    }

    mask := 0
    res := int64(0)
    freq := make(map[int]int64)
    freq[0] = 1

    var dfs func(int)
    dfs = func(u int) {
        mask ^= 1 << (s[u] - 'a')
        res += freq[mask]
        for i := 0; i < 26; i++ {
            res += freq[mask^(1<<i)]
        }
        freq[mask]++
        for _, v := range adj[u] {
            dfs(v)
        }
        mask ^= 1 << (s[u] - 'a')
    }
    dfs(0)
    return res
}