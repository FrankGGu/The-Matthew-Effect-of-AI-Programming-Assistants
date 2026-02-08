func longestWPI(hours []int) int {
    n := len(hours)
    prefixSum := make([]int, n+1)

    for i := 1; i <= n; i++ {
        if hours[i-1] > 8 {
            prefixSum[i] = prefixSum[i-1] + 1
        } else {
            prefixSum[i] = prefixSum[i-1] - 1
        }
    }

    maxLength := 0
    stack := []int{}

    for i := 0; i <= n; i++ {
        if len(stack) == 0 || prefixSum[i] < prefixSum[stack[len(stack)-1]] {
            stack = append(stack, i)
        }
    }

    for i := n; i >= 0; i-- {
        for len(stack) > 0 && prefixSum[i] > prefixSum[stack[len(stack)-1]] {
            maxLength = max(maxLength, i-stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}