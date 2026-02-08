func isTransformable(s string, target string) bool {
    if len(s) != len(target) {
        return false
    }

    countS, countT := make([]int, 10), make([]int, 10)
    for i := 0; i < len(s); i++ {
        countS[s[i]-'0']++
        countT[target[i]-'0']++
    }

    for i := 0; i < 10; i++ {
        if countS[i] < countT[i] {
            return false
        }
    }

    j := 0
    for i := 0; i < 10; i++ {
        for countT[i] > 0 {
            for j < len(s) && (s[j]-'0' != byte(i)) {
                if s[j] < byte(i+'0') {
                    return false
                }
                j++
            }
            if j == len(s) {
                return false
            }
            countT[i]--
            j++
        }
    }

    return true
}