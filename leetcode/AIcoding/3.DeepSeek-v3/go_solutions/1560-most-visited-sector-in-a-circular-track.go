func mostVisited(n int, rounds []int) []int {
    start := rounds[0]
    end := rounds[len(rounds)-1]
    var res []int

    if start <= end {
        for i := start; i <= end; i++ {
            res = append(res, i)
        }
    } else {
        for i := 1; i <= end; i++ {
            res = append(res, i)
        }
        for i := start; i <= n; i++ {
            res = append(res, i)
        }
    }
    return res
}