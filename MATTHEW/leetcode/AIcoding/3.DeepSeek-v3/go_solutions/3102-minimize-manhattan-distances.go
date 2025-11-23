func minimumDistance(points [][]int) int {
    maxSum := math.MinInt32
    minSum := math.MaxInt32
    maxDiff := math.MinInt32
    minDiff := math.MaxInt32

    for _, p := range points {
        sum := p[0] + p[1]
        diff := p[0] - p[1]
        if sum > maxSum {
            maxSum = sum
        }
        if sum < minSum {
            minSum = sum
        }
        if diff > maxDiff {
            maxDiff = diff
        }
        if diff < minDiff {
            minDiff = diff
        }
    }

    return min(maxSum - minSum, maxDiff - minDiff)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}