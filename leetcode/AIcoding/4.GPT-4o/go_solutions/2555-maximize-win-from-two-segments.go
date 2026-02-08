func maximizeWin(piles []int, k int) int {
    n := len(piles)
    sort.Ints(piles)
    maxWin := 0
    j := 0

    for i := 0; i < n; i++ {
        for j < n && piles[j] - piles[i] <= k {
            j++
        }
        maxWin = max(maxWin, j-i)
    }

    return maxWin
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}