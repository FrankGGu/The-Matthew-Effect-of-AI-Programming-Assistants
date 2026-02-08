func maximumRobots(charges []int, budget int) int {
    n := len(charges)
    maxRobots := 0
    left := 0
    currentCost := 0
    maxCharge := 0
    for right := 0; right < n; right++ {
        currentCost += charges[right]
        if charges[right] > maxCharge {
            maxCharge = charges[right]
        }
        for currentCost + maxCharge*(right-left+1) > budget {
            currentCost -= charges[left]
            left++
            maxCharge = 0
            for i := left; i <= right; i++ {
                if charges[i] > maxCharge {
                    maxCharge = charges[i]
                }
            }
        }
        maxRobots = max(maxRobots, right-left+1)
    }
    return maxRobots
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}