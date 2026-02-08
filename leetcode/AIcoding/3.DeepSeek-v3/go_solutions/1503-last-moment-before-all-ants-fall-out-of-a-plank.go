func getLastMoment(n int, left []int, right []int) int {
    maxLeft := 0
    if len(left) > 0 {
        maxLeft = left[0]
        for _, pos := range left {
            if pos > maxLeft {
                maxLeft = pos
            }
        }
    }

    minRight := n
    if len(right) > 0 {
        minRight = right[0]
        for _, pos := range right {
            if pos < minRight {
                minRight = pos
            }
        }
    }

    return max(maxLeft, n - minRight)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}