func makeSmallestPalindrome(s string) string {
    n := len(s)
    sBytes := []byte(s)

    for i := 0; i < n / 2; i++ {
        j := n - 1 - i
        if sBytes[i] != sBytes[j] {
            if sBytes[i] < sBytes[j] {
                sBytes[j] = sBytes[i]
            } else {
                sBytes[i] = sBytes[j]
            }
        }
    }

    return string(sBytes)
}