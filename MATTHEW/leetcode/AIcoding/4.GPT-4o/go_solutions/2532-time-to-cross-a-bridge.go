func canCrossBridge(bridgeLength int, maxWeight int, weights []int) bool {
    currentWeight := 0
    queue := make([]int, 0)
    for i := 0; i < len(weights); i++ {
        currentWeight += weights[i]
        queue = append(queue, weights[i])
        if len(queue) > bridgeLength {
            currentWeight -= queue[0]
            queue = queue[1:]
        }
        if currentWeight > maxWeight {
            return false
        }
    }
    return true
}