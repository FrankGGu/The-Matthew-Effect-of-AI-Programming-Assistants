func distributeCandies(candies int, numChildren int) []int {
    result := make([]int, numChildren)
    for i := 0; candies > 0; i++ {
        index := i % numChildren
        result[index] += min(candies, i+1)
        candies -= i + 1
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}