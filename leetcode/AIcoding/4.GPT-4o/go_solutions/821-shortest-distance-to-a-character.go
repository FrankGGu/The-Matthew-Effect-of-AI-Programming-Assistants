func shortestToChar(s string, c byte) []int {
    n := len(s)
    res := make([]int, n)
    last := -1

    for i := 0; i < n; i++ {
        if s[i] == c {
            last = i
        }
        if last == -1 {
            res[i] = n
        } else {
            res[i] = i - last
        }
    }

    last = -1
    for i := n - 1; i >= 0; i-- {
        if s[i] == c {
            last = i
        }
        if last != -1 {
            res[i] = min(res[i], last-i)
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}