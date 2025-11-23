func maximumBags(capacity []int, rocks []int, additionalRocks int) int {
    n := len(capacity)
    remaining := make([]int, n)
    for i := 0; i < n; i++ {
        remaining[i] = capacity[i] - rocks[i]
    }
    sort.Ints(remaining)
    res := 0
    for i := 0; i < n; i++ {
        if remaining[i] <= additionalRocks {
            additionalRocks -= remaining[i]
            res++
        } else {
            break
        }
    }
    return res
}