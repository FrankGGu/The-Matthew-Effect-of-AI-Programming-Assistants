func minimumSubstringsInPartition(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = i
        freq := make(map[byte]int)
        for j := i; j >= 1; j-- {
            freq[s[j-1]]++
            if isValid(freq) {
                if dp[j-1]+1 < dp[i] {
                    dp[i] = dp[j-1] + 1
                }
            }
        }
    }
    return dp[n]
}

func isValid(freq map[byte]int) bool {
    if len(freq) == 0 {
        return false
    }
    val := -1
    for _, v := range freq {
        if val == -1 {
            val = v
        } else if v != val {
            return false
        }
    }
    return true
}