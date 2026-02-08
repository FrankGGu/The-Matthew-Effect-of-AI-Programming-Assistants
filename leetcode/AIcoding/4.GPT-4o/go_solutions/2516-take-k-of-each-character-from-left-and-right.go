func takeCharacters(s string, k int) int {
    count := make(map[rune]int)
    left := 0
    result := 0
    for right, char := range s {
        count[char]++
        for count[char] > k {
            count[rune(s[left])]--
            left++
        }
        result = max(result, right-left+1)
    }
    return len(s) - result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}