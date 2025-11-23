func maxChunksToSorted(arr []int) int {
    n := len(arr)
    maxLeft := make([]int, n)
    minRight := make([]int, n)

    maxLeft[0] = arr[0]
    for i := 1; i < n; i++ {
        maxLeft[i] = max(maxLeft[i-1], arr[i])
    }

    minRight[n-1] = arr[n-1]
    for i := n-2; i >= 0; i-- {
        minRight[i] = min(minRight[i+1], arr[i])
    }

    res := 0
    for i := 0; i < n-1; i++ {
        if maxLeft[i] <= minRight[i+1] {
            res++
        }
    }

    return res + 1
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