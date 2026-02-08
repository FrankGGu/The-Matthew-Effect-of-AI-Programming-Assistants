func minSwaps(data []int, k int) int {
    ones := 0
    for _, num := range data {
        if num == 1 {
            ones++
        }
    }

    if ones <= k {
        return 0
    }

    windowOnes := 0
    for i := 0; i < k; i++ {
        if data[i] == 1 {
            windowOnes++
        }
    }

    maxOnes := windowOnes
    for i := k; i < len(data); i++ {
        if data[i-k] == 1 {
            windowOnes--
        }
        if data[i] == 1 {
            windowOnes++
        }
        maxOnes = max(maxOnes, windowOnes)
    }

    return k - maxOnes
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}