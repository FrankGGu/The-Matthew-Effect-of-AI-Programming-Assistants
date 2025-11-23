package main

func characterReplacement(s string, k int) int {
    count := make(map[byte]int)
    maxCount := 0
    left := 0
    maxLength := 0

    for right := 0; right < len(s); right++ {
        count[s[right]]++
        maxCount = max(maxCount, count[s[right]])

        for (right - left + 1) - maxCount > k {
            count[s[left]]--
            left++
        }

        maxLength = max(maxLength, right-left+1)
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}