func minChanges(nums []int, k int) int {
    const maxXor = 1024
    n := len(nums)
    freq := make([]map[int]int, k)
    for i := 0; i < k; i++ {
        freq[i] = make(map[int]int)
    }
    for i := 0; i < n; i++ {
        freq[i%k][nums[i]]++
    }

    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, maxXor)
        for j := range dp[i] {
            dp[i][j] = n + 1
        }
    }
    dp[0][0] = 0

    for i := 0; i < k; i++ {
        minPrev := n + 1
        for x := 0; x < maxXor; x++ {
            if dp[i][x] < minPrev {
                minPrev = dp[i][x]
            }
        }
        for x := 0; x < maxXor; x++ {
            dp[i+1][x] = minPrev + (n / k) + boolToInt(i < n%k)
        }
        for num, cnt := range freq[i] {
            for x := 0; x < maxXor; x++ {
                newX := x ^ num
                if dp[i][x] + ( (n / k) + boolToInt(i < n%k) - cnt ) < dp[i+1][newX] {
                    dp[i+1][newX] = dp[i][x] + ( (n / k) + boolToInt(i < n%k) - cnt )
                }
            }
        }
    }

    return dp[k][0]
}

func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}