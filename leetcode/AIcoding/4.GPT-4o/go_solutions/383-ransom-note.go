func canConstruct(ransomNote string, magazine string) bool {
    count := make(map[rune]int)

    for _, char := range magazine {
        count[char]++
    }

    for _, char := range ransomNote {
        if count[char] == 0 {
            return false
        }
        count[char]--
    }

    return true
}