func maximizeTheProfit(n int, offers [][]int) int {
    dp := make([]int, n+1)
    type offer struct {
        start, end, gold int
    }
    sortedOffers := make([]offer, len(offers))
    for i, o := range offers {
        sortedOffers[i] = offer{o[0], o[1], o[2]}
    }
    sort.Slice(sortedOffers, func(i, j int) bool {
        return sortedOffers[i].end < sortedOffers[j].end
    })
    idx := 0
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for idx < len(sortedOffers) && sortedOffers[idx].end < i {
            idx++
        }
        for idx < len(sortedOffers) && sortedOffers[idx].end == i-1 {
            o := sortedOffers[idx]
            if dp[o.start]+o.gold > dp[i] {
                dp[i] = dp[o.start] + o.gold
            }
            idx++
        }
    }
    return dp[n]
}