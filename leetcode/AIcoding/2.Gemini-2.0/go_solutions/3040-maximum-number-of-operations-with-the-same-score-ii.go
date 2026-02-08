func maxOperations(nums []int) int {
    n := len(nums)
    memo := make([][]int, n)
    for i := range memo {
        memo[i] = make([]int, n)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dp func(int, int, int) int
    dp = func(l, r, target int) int {
        if l >= r {
            return 0
        }
        if memo[l][r] != -1 {
            return memo[l][r]
        }

        res := 0
        if nums[l]+nums[l+1] == target {
            res = max(res, 1+dp(l+2, r, target))
        }
        if nums[r-1]+nums[r] == target {
            res = max(res, 1+dp(l, r-2, target))
        }
        if nums[l]+nums[r] == target {
            res = max(res, 1+dp(l+1, r-1, target))
        }

        memo[l][r] = res
        return res
    }

    ans := 0
    ans = max(ans, 1+dp(2, n-1, nums[0]+nums[1]))
    ans = max(ans, 1+dp(1, n-2, nums[0]+nums[n-1]))
    ans = max(ans, 1+dp(0, n-3, nums[n-2]+nums[n-1]))

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}