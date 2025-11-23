func minHeightShelves(books [][]int, shelfWidth int) int {
    n := len(books)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        width := books[i-1][0]
        height := books[i-1][1]
        dp[i] = dp[i-1] + height
        for j := i - 1; j > 0 && width + books[j-1][0] <= shelfWidth; j-- {
            width += books[j-1][0]
            if books[j-1][1] > height {
                height = books[j-1][1]
            }
            if dp[j-1] + height < dp[i] {
                dp[i] = dp[j-1] + height
            }
        }
    }
    return dp[n]
}