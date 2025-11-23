package main

func findHotServers(servers []int, requests []int, time int) []int {
    n := len(servers)
    m := len(requests)
    used := make([]bool, n)
    serverCount := make([]int, n)
    for i := 0; i < n; i++ {
        serverCount[i] = 0
    }
    for i := 0; i < m; i++ {
        reqTime := requests[i]
        if reqTime > time {
            continue
        }
        for j := 0; j < n; j++ {
            if !used[j] && servers[j] <= reqTime {
                used[j] = true
                serverCount[j]++
                break
            }
        }
    }
    maxCount := 0
    for i := 0; i < n; i++ {
        if serverCount[i] > maxCount {
            maxCount = serverCount[i]
        }
    }
    result := make([]int, 0)
    for i := 0; i < n; i++ {
        if serverCount[i] == maxCount {
            result = append(result, i)
        }
    }
    return result
}