func longestDecomposition(text string) int {
    n := len(text)
    res := 0
    left, right := 0, n-1
    l, r := "", ""

    for left <= right {
        l = l + string(text[left])
        r = string(text[right]) + r
        if l == r {
            res++
            if left == right {
                res--
            }
            l, r = "", ""
        }
        left++
        right--
    }

    if l != "" || r != "" {
        res++
    }

    return res
}