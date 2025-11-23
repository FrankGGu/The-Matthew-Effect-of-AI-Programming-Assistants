func distributeCandies(candies int, numChildren int) []int {
    res := make([]int, numChildren)
    for i := 0; candies > 0; i++ {
        res[i%numChildren] += min(candies, i+1)
        candies -= min(candies, i+1)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}