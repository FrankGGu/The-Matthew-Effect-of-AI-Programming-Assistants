func expectNumber(scores []int) int {
    seen := make(map[int]bool)
    count := 0
    for _, score := range scores {
        if !seen[score] {
            seen[score] = true
            count++
        }
    }
    return count
}