func longestOnes(A []int, K int) int {
    left, right := 0, 0
    maxLength := 0

    for right < len(A) {
        if A[right] == 0 {
            K--
        }

        for K < 0 {
            if A[left] == 0 {
                K++
            }
            left++
        }

        maxLength = max(maxLength, right-left+1)
        right++
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}