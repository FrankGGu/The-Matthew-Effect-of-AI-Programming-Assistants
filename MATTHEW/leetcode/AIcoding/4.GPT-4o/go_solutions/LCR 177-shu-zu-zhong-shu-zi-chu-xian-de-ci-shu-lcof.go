func isValidColorCombination(colors []int) bool {
    count := make(map[int]int)
    for _, color := range colors {
        count[color]++
        if count[color] > 2 {
            return false
        }
    }
    return len(count) <= 3
}

func colorCombination(colors []int) bool {
    return isValidColorCombination(colors)
}