func distributeCandies(candies int, num_people int) []int {
    res := make([]int, num_people)
    i := 0
    for candies > 0 {
        res[i%num_people] += min(candies, i+1)
        candies -= i + 1
        i++
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}