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
            shifts[diff]++
        }
    }

    for i := 1; i < 26; i++ {
        maxPossible := (shifts[i] - 1) * 26 + i
        if maxPossible > k {
            return false
        }
    }

    return true
}