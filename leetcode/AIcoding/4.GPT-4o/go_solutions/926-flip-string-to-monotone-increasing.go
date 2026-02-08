func minFlipsMonoIncr(S string) int {
    n := len(S)
    count0 := make([]int, n+1)
    count1 := make([]int, n+1)

    for i := 0; i < n; i++ {
        count0[i+1] = count0[i] + int(S[i] - '0')
        count1[i+1] = count1[i] + 1 - int(S[i] - '0')
    }

    minFlips := n
    for i := 0; i <= n; i++ {
        minFlips = min(minFlips, count0[i]+count1[n]-count1[i])
    }

    return minFlips
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}