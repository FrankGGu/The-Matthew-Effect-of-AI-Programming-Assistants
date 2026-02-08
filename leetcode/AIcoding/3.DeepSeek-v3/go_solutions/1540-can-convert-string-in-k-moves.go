func canConvertString(s string, t string, k int) bool {
    if len(s) != len(t) {
        return false
    }
    shifts := make([]int, 26)
    for i := 0; i < len(s); i++ {
        diff := int(t[i]) - int(s[i])
        if diff < 0 {
            diff += 26
        }
        if diff != 0 {
            if shifts[diff] * 26 + diff > k {
                return false
            }
            shifts[diff]++
        }
    }
    return true
}