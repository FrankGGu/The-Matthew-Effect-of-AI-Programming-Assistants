func characterReplacement(s string, k int) int {
    count := make([]int, 26)
    maxCount := 0
    left := 0
    maxLength := 0

    for right := 0; right < len(s); right++ {
        count[s[right]-'A']++
        if count[s[right]-'A'] > maxCount {
            maxCount = count[s[right]-'A']
        }

        if right-left+1-maxCount > k {
            count[s[left]-'A']--
            left++
        }

        if right-left+1 > maxLength {
            maxLength = right-left+1
        }
    }

    return maxLength
}