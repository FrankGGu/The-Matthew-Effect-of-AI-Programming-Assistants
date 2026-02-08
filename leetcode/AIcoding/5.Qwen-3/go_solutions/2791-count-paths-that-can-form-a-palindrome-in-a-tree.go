package main

func countPalindromePaths(tree []int) int {
    var dfs func(int, int) int
    cnt := make(map[int]int)
    res := 0

    dfs = func(node int, mask int) int {
        if node >= len(tree) || tree[node] == -1 {
            return 0
        }
        mask ^= 1<<tree[node]
        res += cnt[mask]
        if mask == 0 {
            res++
        }
        cnt[mask]++
        left := dfs(2*node+1, mask)
        right := dfs(2*node+2, mask)
        return left + right
    }

    dfs(0, 0)
    return res
}