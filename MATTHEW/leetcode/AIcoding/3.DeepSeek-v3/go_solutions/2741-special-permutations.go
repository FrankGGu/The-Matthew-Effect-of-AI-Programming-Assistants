func specialPerm(nums []int) int {
    n := len(nums)
    mod := int(1e9 + 7)
    memo := make([][]int, 1<<n)
    for i := range memo {
        memo[i] = make([]int, n)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(int, int) int
    dfs = func(mask, last int) int {
        if mask == (1<<n)-1 {
            return 1
        }
        if memo[mask][last] != -1 {
            return memo[mask][last]
        }
        res := 0
        for i := 0; i < n; i++ {
            if mask & (1<<i) == 0 && (nums[last] % nums[i] == 0 || nums[i] % nums[last] == 0) {
                res = (res + dfs(mask | (1<<i), i)) % mod
            }
        }
        memo[mask][last] = res
        return res
    }

    res := 0
    for i := 0; i < n; i++ {
        res = (res + dfs(1<<i, i)) % mod
    }
    return res
}