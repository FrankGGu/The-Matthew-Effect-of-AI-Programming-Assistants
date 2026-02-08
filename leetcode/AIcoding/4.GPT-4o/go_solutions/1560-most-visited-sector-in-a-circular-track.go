func mostVisited(n int, rounds []int) []int {
    start := rounds[0]
    end := rounds[len(rounds)-1]
    if end >= start {
        res := make([]int, end-start+1)
        for i := start; i <= end; i++ {
            res[i-start] = i
        }
        return res
    }
    res := make([]int, n-start+end)
    idx := 0
    for i := start; i <= n; i++ {
        res[idx] = i
        idx++
    }
    for i := 1; i <= end; i++ {
        res[idx] = i
        idx++
    }
    return res
}