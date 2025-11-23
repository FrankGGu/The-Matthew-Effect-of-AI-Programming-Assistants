package main

func maximumGood(s string) int {
    n := len(s)
    maxSum := 0
    for i := 0; i < n; i++ {
        if s[i] == '0' {
            continue
        }
        sum := 0
        for j := i; j < n; j++ {
            if s[j] == '0' {
                break
            }
            sum += 1
            maxSum = max(maxSum, sum)
        }
    }
    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}