func numSub(s string) int {
    const mod = 1e9 + 7
    res, count := 0, 0
    for _, ch := range s {
        if ch == '1' {
            count++
            res = (res + count) % mod
        } else {
            count = 0
        }
    }
    return res
}