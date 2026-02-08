func busiestServers(k int, arrival []int, load []int) []int {
    n := len(arrival)
    busy := make([]int, k)
    servers := make([]int, k)
    available := []int{}
    for i := 0; i < k; i++ {
        available = append(available, i)
    }

    pq := make([][2]int, 0) // [end time, server index]

    for i := 0; i < n; i++ {
        // Free up servers that have finished their load
        for len(pq) > 0 && pq[0][0] <= arrival[i] {
            endTime, server := pq[0][0], pq[0][1]
            pq = pq[1:]
            available = append(available, server)
        }

        if len(available) == 0 {
            continue
        }

        server := available[0]
        available = available[1:]
        busy[server]++
        pq = append(pq, [2]int{arrival[i] + load[i], server})

        // Reorder available servers
        sort.Ints(available)
    }

    maxRequests := 0
    for _, count := range busy {
        if count > maxRequests {
            maxRequests = count
        }
    }

    result := []int{}
    for i := 0; i < k; i++ {
        if busy[i] == maxRequests {
            result = append(result, i)
        }
    }

    return result
}