package main

func maxWidthRamp(A []int) int {
    n := len(A)
    maxWidth := 0
    stack := make([]int, 0)

    for i := 0; i < n; i++ {
        if len(stack) == 0 || A[i] < A[stack[len(stack)-1]] {
            stack = append(stack, i)
        }
    }

    for i := n - 1; i > 0; i-- {
        for len(stack) > 0 && A[i] >= A[stack[len(stack)-1]] {
            maxWidth = max(maxWidth, i - stack[len(stack)-1])
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