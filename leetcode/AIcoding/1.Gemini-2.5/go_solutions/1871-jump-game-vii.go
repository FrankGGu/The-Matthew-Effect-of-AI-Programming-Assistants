func canReach(s string, minJump int, maxJump int) bool {
    n := len(s)

    dp := make([]bool, n)
    dp[0] = true

    prefixSum := make([]int, n + 1)
    prefixSum[1] = 1 

    for i := 1; i < n; i++ {
        if s[i] == '1' {
            prefixSum[i+1] = prefixSum[i]
            continue
        }

        leftBound := i - maxJump
        if leftBound < 0 {
            leftBound = 0
        }

        rightBound := i - minJump

        currentReachableCount := 0
        if rightBound >= leftBound {
            currentReachableCount = prefixSum[rightBound+1] - prefixSum[leftBound]
        }

        if currentReachableCount > 0 {
            dp[i] = true
        }

        prefixSum[i+1] = prefixSum[i]
        if dp[i] {
            prefixSum[i+1]++
        }
    }

    return dp[n-1]
}