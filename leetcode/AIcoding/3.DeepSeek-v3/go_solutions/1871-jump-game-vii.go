func canReach(s string, minJump int, maxJump int) bool {
    n := len(s)
    if s[n-1] != '0' {
        return false
    }
    dp := make([]bool, n)
    dp[0] = true
    pre := 0
    for i := 1; i < n; i++ {
        if i >= minJump && dp[i-minJump] {
            pre++
        }
        if i > maxJump && dp[i-maxJump-1] {
            pre--
        }
        dp[i] = pre > 0 && s[i] == '0'
    }
    return dp[n-1]
}