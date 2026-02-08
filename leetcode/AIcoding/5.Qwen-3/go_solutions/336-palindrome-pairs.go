package main

func palindromePairs(words []string) [][]int {
    wordToIndex := make(map[string]int)
    for i, word := range words {
        wordToIndex[word] = i
    }

    result := [][]int{}

    for i, word := range words {
        for j := 0; j < len(word); j++ {
            left := word[:j]
            right := word[j:]
            if isPalindrome(left) {
                revRight := reverse(right)
                if idx, ok := wordToIndex[revRight]; ok && idx != i {
                    result = append(result, []int{idx, i})
                }
            }
            if isPalindrome(right) {
                revLeft := reverse(left)
                if idx, ok := wordToIndex[revLeft]; ok && idx != i {
                    result = append(result, []int{i, idx})
                }
            }
        }
    }

    return result
}

func isPalindrome(s string) bool {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}