func supplyWagon(supplies []int) []int {
    n := len(supplies)
    target := n / 2
    for len(supplies) > target {
        minSum := supplies[0] + supplies[1]
        minIdx := 0
        for i := 1; i < len(supplies)-1; i++ {
            sum := supplies[i] + supplies[i+1]
            if sum < minSum {
                minSum = sum
                minIdx = i
            }
        }
        supplies[minIdx] += supplies[minIdx+1]
        supplies = append(supplies[:minIdx+1], supplies[minIdx+2:]...)
    }
    return supplies
}