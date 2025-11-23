func maxCoins(bags []int, k int) int {
    n := len(bags)
    sort.Sort(sort.Reverse(sort.IntSlice(bags)))
    maxCoins := 0
    for i := 0; i < k; i++ {
        maxCoins += bags[i]
    }
    return maxCoins
}