func reverseStr(s string, k int) string {
    bytes := []byte(s)
    n := len(bytes)
    for i := 0; i < n; i += 2 * k {
        left := i
        right := i + k - 1
        if right >= n {
            right = n - 1
        }
        for left < right {
            bytes[left], bytes[right] = bytes[right], bytes[left]
            left++
            right--
        }
    }
    return string(bytes)
}