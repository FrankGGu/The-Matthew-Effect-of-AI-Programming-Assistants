func minSumOfLengths(arr []int, target int) int {
    n := len(arr)
    prefix := make(map[int]int)
    prefix[0] = -1
    sum := 0
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = math.MaxInt32
    }
    res := math.MaxInt32
    minLen := math.MaxInt32

    for i := 0; i < n; i++ {
        sum += arr[i]
        prefix[sum] = i
    }
    sum = 0

    for i := 0; i < n; i++ {
        sum += arr[i]
        if val, ok := prefix[sum-target]; ok {
            if val != -1 {
                if val >= 0 && dp[val] != math.MaxInt32 {
                    res = min(res, i-val+dp[val])
                }
                minLen = min(minLen, i-val)
            }
        }
        dp[i] = minLen
        if i > 0 {
            dp[i] = min(dp[i], dp[i-1])
        }
    }

    if res == math.MaxInt32 {
        return -1
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}