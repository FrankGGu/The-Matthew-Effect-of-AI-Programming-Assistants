func minimumTime(s string) int {
    n := len(s)
    left := make([]int, n+1)
    for i := 0; i < n; i++ {
        if s[i] == '1' {
            left[i+1] = min(left[i]+2, i+1)
        } else {
            left[i+1] = left[i]
        }
    }

    right := 0
    res := left[n]
    for i := n - 1; i >= 0; i-- {
        if s[i] == '1' {
            right = min(right+2, n-i)
        }
        res = min(res, left[i]+right)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}