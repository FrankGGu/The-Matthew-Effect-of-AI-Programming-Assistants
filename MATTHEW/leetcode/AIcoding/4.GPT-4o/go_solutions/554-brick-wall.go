func leastBricks(wall [][]int) int {
    gapCount := make(map[int]int)
    for _, row := range wall {
        sum := 0
        for i := 0; i < len(row)-1; i++ {
            sum += row[i]
            gapCount[sum]++
        }
    }

    maxGaps := 0
    for _, count := range gapCount {
        if count > maxGaps {
            maxGaps = count
        }
    }

    return len(wall) - maxGaps
}