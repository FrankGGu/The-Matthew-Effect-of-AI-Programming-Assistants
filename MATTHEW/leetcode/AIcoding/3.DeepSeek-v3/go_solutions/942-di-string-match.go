func diStringMatch(s string) []int {
    n := len(s)
    res := make([]int, n+1)
    low, high := 0, n
    for i := 0; i < n; i++ {
        if s[i] == 'I' {
            res[i] = low
            low++
        } else {
            res[i] = high
            high--
        }
    }
    res[n] = low
    return res
}