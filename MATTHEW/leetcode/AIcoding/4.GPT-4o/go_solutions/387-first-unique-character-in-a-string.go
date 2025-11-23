func firstUniqChar(s string) int {
    count := make([]int, 26)
    for _, char := range s {
        count[char-'a']++
    }
    for i, char := range s {
        if count[char-'a'] == 1 {
            return i
        }
    }
    return -1
}