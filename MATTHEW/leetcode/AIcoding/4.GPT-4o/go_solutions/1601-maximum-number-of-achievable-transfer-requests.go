func maximumRequests(n int, requests [][]int) int {
    maxRequests := 0
    totalRequests := len(requests)

    for mask := 0; mask < (1 << totalRequests); mask++ {
        balance := make([]int, n)
        count := 0

        for i := 0; i < totalRequests; i++ {
            if mask&(1<<i) > 0 {
                balance[requests[i][0]]--
                balance[requests[i][1]]++
                count++
            }
        }

        valid := true
        for _, b := range balance {
            if b != 0 {
                valid = false
                break
            }
        }

        if valid {
            maxRequests = max(maxRequests, count)
        }
    }

    return maxRequests
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}