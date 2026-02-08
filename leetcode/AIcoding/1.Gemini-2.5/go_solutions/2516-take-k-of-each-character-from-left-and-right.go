func takeCharacters(s string, k int) int {
    n := len(s)

    totalCounts := [3]int{}
    for _, char := range s {
        totalCounts[char-'a']++
    }

    if totalCounts[0] < k || totalCounts[1] < k || totalCounts[2] < k {
        return -1
    }

    targetCounts := [3]int{totalCounts[0] - k, totalCounts[1] - k, totalCounts[2] - k}

    maxLen := 0
    left := 0
    currentWindowCounts := [3]int{}

    for right := 0; right < n; right++ {
        charIndex := s[right] - 'a'
        currentWindowCounts[charIndex]++

        for currentWindowCounts[0] > targetCounts[0] ||
            currentWindowCounts[1] > targetCounts[1] ||
            currentWindowCounts[2] > targetCounts[2] {

            removeCharIndex := s[left] - 'a'
            currentWindowCounts[removeCharIndex]--
            left++
        }

        maxLen = max(maxLen, right-left+1)
    }

    return n - maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}