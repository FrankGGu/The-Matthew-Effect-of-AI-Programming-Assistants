func makeSmallestPalindrome(s string) string {
    bytes := []byte(s)
    left, right := 0, len(bytes)-1
    for left < right {
        if bytes[left] != bytes[right] {
            if bytes[left] < bytes[right] {
                bytes[right] = bytes[left]
            } else {
                bytes[left] = bytes[right]
            }
        }
        left++
        right--
    }
    return string(bytes)
}