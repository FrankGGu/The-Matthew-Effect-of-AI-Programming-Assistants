func palindromePairs(words []string) [][]int {
    indexMap := make(map[string]int)
    for i, word := range words {
        indexMap[word] = i
    }

    var result [][]int

    for i, word := range words {
        n := len(word)
        for j := 0; j <= n; j++ {
            left := word[:j]
            right := word[j:]

            if isPalindrome(left) {
                reverseRight := reverse(right)
                if idx, ok := indexMap[reverseRight]; ok && idx != i {
                    result = append(result, []int{idx, i})
                }
            }

            if j < n && isPalindrome(right) {
                reverseLeft := reverse(left)
                if idx, ok := indexMap[reverseLeft]; ok && idx != i {
                    result = append(result, []int{i, idx})
                }
            }
        }
    }

    return result
}

func isPalindrome(s string) bool {
    left, right := 0, len(s)-1
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
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