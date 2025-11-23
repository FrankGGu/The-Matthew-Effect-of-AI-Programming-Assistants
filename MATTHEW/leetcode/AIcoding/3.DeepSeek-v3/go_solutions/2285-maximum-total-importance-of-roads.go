func maximumImportance(n int, roads [][]int) int64 {
    degree := make([]int, n)
    for _, road := range roads {
        degree[road[0]]++
        degree[road[1]]++
    }
    sort.Ints(degree)
    var res int64
    for i := 0; i < n; i++ {
        res += int64(degree[i] * (i + 1))
    }
    return res
}