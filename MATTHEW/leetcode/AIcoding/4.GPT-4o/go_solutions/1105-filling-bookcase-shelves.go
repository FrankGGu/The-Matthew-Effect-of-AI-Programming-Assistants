func minHeightShelves(books [][]int, shelf_width int) int {
    n := len(books)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        width, height := 0, 0
        dp[i] = dp[i-1] + books[i-1][1]
        for j := i - 1; j >= 0 && width+books[j][0] <= shelf_width; j-- {
            width += books[j][0]
            if books[j][1] > height {
                height = books[j][1]
            }
            dp[i] = min(dp[i], dp[j] + height)
        }
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}