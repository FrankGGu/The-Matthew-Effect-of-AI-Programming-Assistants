func smallestString(s string, k int) string {
    if k == 0 {
        return s
    }

    chars := []rune(s)
    n := len(chars)

    for i := 0; i < n; i++ {
        if k == 0 {
            break
        }
        if chars[i] > 'a' {
            diff := int(chars[i] - 'a')
            if diff <= k {
                chars[i] = 'a'
                k -= diff
            } else {
                chars[i] -= rune(k)
                k = 0
            }
        }
    }

    return string(chars)
}