func minFlips(s string) int {
    n := len(s)
    s = s + s
    count1, count2 := 0, 0
    for i := 0; i < n; i++ {
        if s[i] != byte('0'+i%2) {
            count1++
        }
        if s[i] != byte('1'-i%2) {
            count2++
        }
    }
    res := min(count1, count2)
    for i := n; i < 2*n; i++ {
        if s[i] != byte('0'+i%2) {
            count1++
        } else {
            count1--
        }
        if s[i] != byte('1'-i%2) {
            count2++
        } else {
            count2--
        }
        if i >= n {
            res = min(res, min(count1, count2))
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