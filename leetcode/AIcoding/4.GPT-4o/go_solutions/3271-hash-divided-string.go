func hashDividedString(s string) bool {
    hashMap := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        hashMap[s[i]]++
    }
    for _, count := range hashMap {
        if count%2 != 0 {
            return false
        }
    }
    return true
}