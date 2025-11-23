func beautifulTowers(n int, heights []int) int {
    sort.Ints(heights)
    res := 0
    for i := 0; i < n; i++ {
        if i == 0 || heights[i] > heights[i-1] {
            res++
        }
    }
    return res
}