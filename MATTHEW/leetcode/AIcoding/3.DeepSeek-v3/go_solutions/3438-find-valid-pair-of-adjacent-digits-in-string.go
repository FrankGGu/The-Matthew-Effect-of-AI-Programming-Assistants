func findValidPair(s string) bool {
    for i := 0; i < len(s)-1; i++ {
        a := int(s[i] - '0')
        b := int(s[i+1] - '0')
        if (a+b)%2 == 1 {
            return true
        }
    }
    return false
}