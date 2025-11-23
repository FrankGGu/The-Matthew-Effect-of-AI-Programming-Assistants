func numOccurrences(scores []int, target int) int {
    count := 0
    for _, score := range scores {
        if score == target {
            count++
        }
    }
    return count
}