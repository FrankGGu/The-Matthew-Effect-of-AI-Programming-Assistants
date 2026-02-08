func maxConsecutiveAnswers(answerKey string, k int) int {
    left, maxCount, maxLength := 0, 0, 0
    count := map[rune]int{}

    for right := 0; right < len(answerKey); right++ {
        count[rune(answerKey[right])]++
        maxCount = max(maxCount, count[rune(answerKey[right])])

        while right-left+1-maxCount > k {
            count[rune(answerKey[left])]--
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