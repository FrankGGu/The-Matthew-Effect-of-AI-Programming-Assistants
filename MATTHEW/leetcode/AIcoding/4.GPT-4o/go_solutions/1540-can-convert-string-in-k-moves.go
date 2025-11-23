func canConvertString(s string, t string, k int) bool {
    if len(s) != len(t) {
        return false
    }

    count := make([]int, 26)

    for i := 0; i < len(s); i++ {
        diff := (int(t[i]-'a') - int(s[i]-'a') + 26) % 26
        if diff != 0 {
            count[diff]++
        }
    }

    for i := 1; i < 26; i++ {
        if count[i] > 0 {
            if k < i*count[i] + (count[i]-1)*26 {
                return false
            }
        }
    }

    return true
}