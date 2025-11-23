func canConstruct(ransomNote string, magazine string) bool {
    letterCount := make(map[rune]int)

    for _, char := range magazine {
        letterCount[char]++
    }

    for _, char := range ransomNote {
        if letterCount[char] == 0 {
            return false
        }
        letterCount[char]--
    }

    return true
}