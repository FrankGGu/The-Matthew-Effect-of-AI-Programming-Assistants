func maxConsecutiveAnswers(answerKey string, k int) int {
    return max(maxConsecutiveChar(answerKey, k, 'T'), maxConsecutiveChar(answerKey, k, 'F'))
}

func maxConsecutiveChar(s string, k int, target byte) int {
    left, sum, res := 0, 0, 0
    for right := 0; right < len(s); right++ {
        if s[right] != target {
            sum++
        }
        for sum > k {
            if s[left] != target {
                sum--
            }
            left++
        }
        res = max(res, right - left + 1)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}