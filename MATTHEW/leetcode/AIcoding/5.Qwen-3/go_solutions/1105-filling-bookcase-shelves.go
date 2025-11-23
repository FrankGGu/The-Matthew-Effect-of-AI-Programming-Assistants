package main

func minHeightShelves(books [][]int, shelfWidth int) int {
    n := len(books)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        maxH := 0
        dp[i] = 1 << 31
        for j := i - 1; j >= 0 && shelfWidth >= books[j][0]; j-- {
            maxH = max(maxH, books[j][1])
            dp[i] = min(dp[i], dp[j]+maxH)
        }
    }
    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}