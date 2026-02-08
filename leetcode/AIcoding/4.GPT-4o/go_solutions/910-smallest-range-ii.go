func smallestRangeII(A []int, K int) int {
    minVal, maxVal := A[0], A[0]
    for _, num := range A {
        if num < minVal {
            minVal = num
        }
        if num > maxVal {
            maxVal = num
        }
    }

    result := maxVal - minVal
    for _, num := range A {
        newMin := min(minVal+K, num-K)
        newMax := max(maxVal-K, num+K)
        result = min(result, newMax-newMin)
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}