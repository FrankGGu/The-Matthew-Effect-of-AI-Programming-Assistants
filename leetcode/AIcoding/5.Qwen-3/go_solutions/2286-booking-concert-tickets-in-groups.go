package main

func maxConsecutiveAnswers(answerKey string, k int) int {
    left := 0
    maxLen := 0
    count := map[byte]int{}

    for right := 0; right < len(answerKey); right++ {
        count[answerKey[right]]++

        for count['T'] > k && count['F'] > k {
            count[answerKey[left]]--
            left++
        }

        maxLen = max(maxLen, right-left+1)
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}