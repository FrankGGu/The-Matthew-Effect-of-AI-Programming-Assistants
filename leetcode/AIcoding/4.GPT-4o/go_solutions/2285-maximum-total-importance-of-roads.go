func maximumImportance(n int, roads [][]int) int64 {
    degree := make([]int, n)
    for _, road := range roads {
        degree[road[0]]++
        degree[road[1]]++
    }

    sort.Slice(degree, func(i, j int) bool {
        return degree[i] > degree[j]
    })

    var totalImportance int64
    for i := 0; i < n; i++ {
        totalImportance += int64(degree[i]) * int64(i+1)
    }

    return totalImportance
}