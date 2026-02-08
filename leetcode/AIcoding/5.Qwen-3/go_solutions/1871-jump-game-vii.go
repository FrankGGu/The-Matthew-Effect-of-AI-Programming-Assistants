package main

func canReach(s string, minJump int, maxJump int) bool {
    n := len(s)
    dp := make([]bool, n)
    dp[0] = true
    cnt := 1
    for i := 1; i < n; i++ {
        if s[i] == '0' {
            if i >= minJump {
                cnt += dp[i-minJump]
            }
            if i > maxJump {
                cnt -= dp[i-maxJump-1]
            }
            if cnt > 0 {
                dp[i] = true
            }
        }
    }
    return dp[n-1]
}