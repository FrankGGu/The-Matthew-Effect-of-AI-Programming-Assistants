func diStringMatch(s string) []int {
    n := len(s)
    ans := make([]int, n+1)
    low, high := 0, n

    for i := 0; i < n; i++ {
        if s[i] == 'I' {
            ans[i] = low
            low++
        } else {
            ans[i] = high
            high--
        }
    }
    ans[n] = low // or ans[n] = high, both are the same at this point
    return ans
}