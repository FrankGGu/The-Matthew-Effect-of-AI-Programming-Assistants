func minimumValueSum(nums []int, andValues []int) int {
    n, m := len(nums), len(andValues)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var dfs func(i, j, currentAnd int) int
    dfs = func(i, j, currentAnd int) int {
        if j == m {
            if i == n {
                return 0
            }
            return -1
        }
        if i == n {
            return -1
        }
        newAnd := currentAnd & nums[i]
        if newAnd < andValues[j] {
            return -1
        }
        if dp[i][j] != -1 && newAnd == currentAnd {
            return dp[i][j]
        }
        res := -1
        if newAnd == andValues[j] {
            next := dfs(i+1, j+1, ^0)
            if next != -1 {
                res = nums[i] + next
            }
        }
        next := dfs(i+1, j, newAnd)
        if next != -1 {
            if res == -1 || nums[i] + next < res {
                res = nums[i] + next
            }
        }
        if newAnd == currentAnd {
            dp[i][j] = res
        }
        return res
    }

    return dfs(0, 0, ^0)
}