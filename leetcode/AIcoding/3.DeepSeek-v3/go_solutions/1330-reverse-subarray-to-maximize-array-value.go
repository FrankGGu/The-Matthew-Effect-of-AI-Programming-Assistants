func maxValueAfterReverse(nums []int) int {
    n := len(nums)
    if n == 1 {
        return 0
    }

    original := 0
    for i := 0; i < n-1; i++ {
        original += abs(nums[i] - nums[i+1])
    }

    maxGain := 0

    minPair := min(nums[0], nums[1])
    maxPair := max(nums[0], nums[1])

    for i := 1; i < n-1; i++ {
        a, b := nums[i], nums[i+1]
        currentMin := min(a, b)
        currentMax := max(a, b)
        if currentMin > maxPair {
            maxGain = max(maxGain, 2*(currentMin - maxPair))
        }
        if currentMax < minPair {
            maxGain = max(maxGain, 2*(minPair - currentMax))
        }
        minPair = min(minPair, currentMax)
        maxPair = max(maxPair, currentMin)
    }

    edge1 := 0
    for i := 0; i < n-1; i++ {
        edge1 = max(edge1, abs(nums[0]-nums[i+1]) - abs(nums[i]-nums[i+1]))
    }

    edge2 := 0
    for i := 0; i < n-1; i++ {
        edge2 = max(edge2, abs(nums[n-1]-nums[i]) - abs(nums[i]-nums[i+1]))
    }

    maxGain = max(maxGain, max(edge1, edge2))

    return original + maxGain
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
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