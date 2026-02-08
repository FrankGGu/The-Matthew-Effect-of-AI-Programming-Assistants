func palindromePairs(words []string) [][]int {
    var res [][]int
    wordMap := make(map[string]int)
    for i, word := range words {
        wordMap[word] = i
    }

    for i, word := range words {
        n := len(word)
        for j := 0; j <= n; j++ {
            prefix := word[:j]
            suffix := word[j:]
            if isPalindrome(prefix) {
                reversedSuffix := reverseString(suffix)
                if idx, ok := wordMap[reversedSuffix]; ok && idx != i {
                    res = append(res, []int{idx, i})
                }
            }
            if j != n && isPalindrome(suffix) {
                reversedPrefix := reverseString(prefix)
                if idx, ok := wordMap[reversedPrefix]; ok && idx != i {
                    res = append(res, []int{i, idx})
                }
            }
        }
    }
    return res
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

func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}