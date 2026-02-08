func getSmallestString(n int, k int) string {
    res := make([]byte, n)
    for i := 0; i < n; i++ {
        if k > 26 {
            res[i] = 'a'
            k -= 1
        } else {
            res[i] = 'a' + byte(k-1)
            k = 0
        }
    }

    for i := n - 1; i >= 0 && k > 0; i-- {
        if res[i] < 'z' {
            add := min(k, 25-int(res[i]-'a'))
            res[i] += byte(add)
            k -= add
        }
    }

    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}