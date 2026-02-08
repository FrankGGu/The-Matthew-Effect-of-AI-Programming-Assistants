func digitCount(num string) bool {
    count := make([]int, 10)
    for _, ch := range num {
        count[ch-'0']++
    }
    for i, ch := range num {
        if count[i] != int(ch-'0') {
            return false
        }
    }
    return true
}