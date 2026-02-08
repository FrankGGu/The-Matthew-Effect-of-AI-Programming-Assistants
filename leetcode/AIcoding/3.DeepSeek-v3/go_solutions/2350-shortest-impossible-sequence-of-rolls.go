func shortestSequence(rolls []int, k int) int {
    seen := make(map[int]bool)
    res := 1
    for _, num := range rolls {
        seen[num] = true
        if len(seen) == k {
            res++
            seen = make(map[int]bool)
        }
    }
    return res
}