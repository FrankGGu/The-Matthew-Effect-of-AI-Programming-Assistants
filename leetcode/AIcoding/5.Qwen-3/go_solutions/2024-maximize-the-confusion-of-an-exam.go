package main

func maxConsecutiveAnswers(s string, k int) int {
    maxCount := 0
    count := make(map[byte]int)
    left := 0
    for right := 0; right < len(s); right++ {
        count[s[right]]++
        if count['T'] > count['F'] {
            if count['T']-count['F'] > k {
                count[s[left]]--
                left++
            }
        } else {
            if count['F']-count['T'] > k {
                count[s[left]]--
                left++
            }
        }
        maxCount = max(maxCount, right-left+1)
    }
    return maxCount
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}