func partitionDisjoint(A []int) int {
    n := len(A)
    leftMax := make([]int, n)
    rightMin := make([]int, n)

    leftMax[0] = A[0]
    for i := 1; i < n; i++ {
        leftMax[i] = max(leftMax[i-1], A[i])
    }

    rightMin[n-1] = A[n-1]
    for i := n - 2; i >= 0; i-- {
        rightMin[i] = min(rightMin[i+1], A[i])
    }

    for i := 0; i < n-1; i++ {
        if leftMax[i] <= rightMin[i+1] {
            return i + 1
        }
    }
    return n
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}