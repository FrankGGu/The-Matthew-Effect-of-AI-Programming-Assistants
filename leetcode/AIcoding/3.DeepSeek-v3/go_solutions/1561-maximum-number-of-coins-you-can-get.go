func maxCoins(piles []int) int {
    sort.Ints(piles)
    res := 0
    n := len(piles)
    for i := n / 3; i < n; i += 2 {
        res += piles[i]
    }
    return res
}