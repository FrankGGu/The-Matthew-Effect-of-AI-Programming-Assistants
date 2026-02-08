func miceAndCheese(reward1 []int, reward2 []int, k int) int {
    n := len(reward1)
    diffs := make([]int, n)
    total := 0
    for i := 0; i < n; i++ {
        diffs[i] = reward1[i] - reward2[i]
        total += reward2[i]
    }
    sort.Slice(diffs, func(i, j int) bool {
        return diffs[i] > diffs[j]
    })
    for i := 0; i < k; i++ {
        total += diffs[i]
    }
    return total
}