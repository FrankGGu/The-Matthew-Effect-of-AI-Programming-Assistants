func beautifulArray(n int) []int {
    if n == 1 {
        return []int{1}
    }
    left := beautifulArray((n + 1) / 2)
    right := beautifulArray(n / 2)
    res := make([]int, 0, n)
    for _, num := range left {
        res = append(res, 2*num-1)
    }
    for _, num := range right {
        res = append(res, 2*num)
    }
    return res
}