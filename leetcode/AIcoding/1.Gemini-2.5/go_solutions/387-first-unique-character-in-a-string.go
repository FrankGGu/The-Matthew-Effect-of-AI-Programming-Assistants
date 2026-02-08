func firstUniqChar(s string) int {
    counts := [26]int{}

    for _, char := range s {
        counts[char - 'a']++
    }

    for i, char := range s {
        if counts[char - 'a'] == 1 {
            return i
        }
    }

    return -1
}