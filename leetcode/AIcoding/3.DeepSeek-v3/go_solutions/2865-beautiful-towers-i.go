func maximumSumOfHeights(maxHeights []int) int64 {
    n := len(maxHeights)
    res := int64(0)

    for i := 0; i < n; i++ {
        sum := int64(maxHeights[i])
        prev := maxHeights[i]

        for j := i-1; j >= 0; j-- {
            prev = min(prev, maxHeights[j])
            sum += int64(prev)
        }

        prev = maxHeights[i]
        for j := i+1; j < n; j++ {
            prev = min(prev, maxHeights[j])
            sum += int64(prev)
        }

        if sum > res {
            res = sum
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}