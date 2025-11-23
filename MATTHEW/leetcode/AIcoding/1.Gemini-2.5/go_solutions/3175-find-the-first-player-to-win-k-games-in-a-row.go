func findWinningPlayer(skills []int, k int) int {
    n := len(skills)

    // Optimization: If k is greater than or equal to n-1,
    // the player with the maximum skill will eventually win k games in a row.
    // This is because once the player with the highest skill reaches the