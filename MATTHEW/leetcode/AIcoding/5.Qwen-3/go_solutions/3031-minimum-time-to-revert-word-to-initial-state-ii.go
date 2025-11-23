package main

func minimumTimeToInitialState(word string, speed int) int {
    n := len(word)
    dp := make([]int, n)
    for i := 1; i < n; i++ {
        j := dp[i-1]
        for j > 0 && word[i] != word[j] {
            j = dp[j-1]
        }
        if word[i] == word[j] {
            j++
        }
        dp[i] = j
    }
    maxPrefix := dp[n-1]
    if maxPrefix == 0 {
        return (n + speed - 1) / speed
    }
    return (n - maxPrefix + speed - 1) / speed
}