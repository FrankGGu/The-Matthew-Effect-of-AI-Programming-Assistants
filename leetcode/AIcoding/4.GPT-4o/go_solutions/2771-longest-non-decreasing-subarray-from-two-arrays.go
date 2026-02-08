func longestNonDecreasing(A []int, B []int) int {
    n := len(A)
    maxLength := 0
    left := 0

    for right := 0; right < n; right++ {
        if right > 0 && A[right] < A[right-1] && B[right] < B[right-1] {
            left = right
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