func longestObstacleCourseAtEachPosition(obstacles []int) []int {
    n := len(obstacles)
    res := make([]int, n)
    dp := make([]int, 0, n)

    for i, num := range obstacles {
        idx := sort.SearchInts(dp, num+1)
        if idx == len(dp) {
            dp = append(dp, num)
        } else {
            dp[idx] = num
        }
        res[i] = idx + 1
    }
    return res
}