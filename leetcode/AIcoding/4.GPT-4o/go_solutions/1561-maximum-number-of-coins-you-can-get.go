func maxCoins(piles []int) int {
    sort.Ints(piles)
    n := len(piles) / 3
    total := 0
    for i := 0; i < n; i++ {
        total += piles[len(piles)-2-i]
    }
    return total
}