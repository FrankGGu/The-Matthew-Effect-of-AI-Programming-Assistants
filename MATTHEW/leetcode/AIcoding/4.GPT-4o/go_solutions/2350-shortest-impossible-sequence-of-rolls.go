func shortestSequence(rolls []int, k int) int {
    seen := make(map[int]int)
    for i := 0; i < len(rolls); i++ {
        seen[rolls[i]]++
        if len(seen) == k {
            return i + 1
        }
    }
    return len(rolls) + 1
}