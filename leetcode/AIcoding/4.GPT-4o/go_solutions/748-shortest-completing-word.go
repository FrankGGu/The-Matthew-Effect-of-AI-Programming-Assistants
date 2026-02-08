func shortestCompletingWord(licensePlate string, words []string) string {
    count := make([]int, 26)
    for _, ch := range licensePlate {
        if ch >= 'a' && ch <= 'z' {
            count[ch-'a']++
        } else if ch >= 'A' && ch <= 'Z' {
            count[ch-'A']++
        }
    }

    result := ""
    for _, word := range words {
        wordCount := make([]int, 26)
        for _, ch := range word {
            wordCount[ch-'a']++
        }

        valid := true
        for i := 0; i < 26; i++ {
            if count[i] > wordCount[i] {
                valid = false
                break
            }
        }

        if valid {
            if result == "" || len(word) < len(result) {
                result = word
            }
        }
    }

    return result
}