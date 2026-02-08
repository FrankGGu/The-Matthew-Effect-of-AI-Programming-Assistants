func minFlips(s string) int {
    n := len(s)
    s += s
    target1 := make([]byte, len(s))
    target2 := make([]byte, len(s))
    for i := 0; i < len(s); i++ {
        if i%2 == 0 {
            target1[i] = '0'
            target2[i] = '1'
        } else {
            target1[i] = '1'
            target2[i] = '0'
        }
    }
    res := math.MaxInt32
    diff1, diff2 := 0, 0
    left := 0
    for right := 0; right < len(s); right++ {
        if s[right] != target1[right] {
            diff1++
        }
        if s[right] != target2[right] {
            diff2++
        }
        if right >= n {
            if s[left] != target1[left] {
                diff1--
            }
            if s[left] != target2[left] {
                diff2--
            }
            left++
        }
        if right >= n-1 {
            res = min(res, min(diff1, diff2))
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