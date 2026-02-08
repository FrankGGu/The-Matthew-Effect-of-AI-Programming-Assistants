func getKthCharacter(s string, k int) byte {
    n := len(s)
    if n == 0 || k < 1 || k > n {
        return 0
    }
    return s[k-1]
}