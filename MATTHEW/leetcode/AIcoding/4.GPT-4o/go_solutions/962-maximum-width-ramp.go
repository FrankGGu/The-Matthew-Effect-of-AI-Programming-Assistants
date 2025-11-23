func maxWidthRamp(A []int) int {
    n := len(A)
    maxWidth := 0
    stack := []int{}

    for i := 0; i < n; i++ {
        if len(stack) == 0 || A[i] < A[stack[len(stack)-1]] {
            stack = append(stack, i)
        }
    }

    for j := n - 1; j >= 0; j-- {
        for len(stack) > 0 && A[j] >= A[stack[len(stack)-1]] {
            maxWidth = max(maxWidth, j-stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        }
    }

    return maxWidth
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}