func countServers(n int, logs [][]int, x int, queries []int) []int {
    logTimes := make([]int, len(logs))
    for i, log := range logs {
        logTimes[i] = log[1]
    }
    sort.Slice(logs, func(i, j int) bool {
        return logs[i][1] < logs[j][1]
    })
    sort.Ints(logTimes)

    queryWithIndices := make([][2]int, len(queries))
    for i, q := range queries {
        queryWithIndices[i] = [2]int{q, i}
    }
    sort.Slice(queryWithIndices, func(i, j int) bool {
        return queryWithIndices[i][0] < queryWithIndices[j][0]
    })

    res := make([]int, len(queries))
    active := make(map[int]int)
    left, right := 0, 0

    for _, query := range queryWithIndices {
        q, idx := query[0], query[1]
        start, end := q-x, q

        for right < len(logs) && logs[right][1] <= end {
            server := logs[right][0]
            active[server]++
            right++
        }

        for left < len(logs) && logs[left][1] < start {
            server := logs[left][0]
            active[server]--
            if active[server] == 0 {
                delete(active, server)
            }
            left++
        }

        res[idx] = n - len(active)
    }

    return res
}