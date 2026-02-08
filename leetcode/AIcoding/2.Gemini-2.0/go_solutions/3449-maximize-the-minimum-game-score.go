func maximizeTheMinimumGameScore(nums []int, k int) int64 {
    n := len(nums)
    prefixSum := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + int64(nums[i])
    }

    dp := make([][]int64, n+1)
    for i := range dp {
        dp[i] = make([]int64, k+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var solve func(int, int) int64
    solve = func(idx int, count int) int64 {
        if count == 0 {
            if idx == n {
                return 0
            }
            return -1
        }

        if idx == n {
            return -1
        }

        if dp[idx][count] != -1 {
            return dp[idx][count]
        }

        ans := int64(-1)
        for i := idx; i < n; i++ {
            next := solve(i+1, count-1)
            if next != -1 {
                currScore := prefixSum[i+1] - prefixSum[idx]
                minScore := currScore
                if next > 0 {
                    minScore = min(currScore, next)
                }
                if ans == -1 || minScore > ans {
                    ans = minScore
                }
            }
        }

        dp[idx][count] = ans
        return ans
    }

    return solve(0, k)
}

func min(a, b int64) int64 {
    if a < b {
        return a
    }
    return b
}