func maximumRequests(n int, requests [][]int) int {
    max := 0
    m := len(requests)

    for mask := 0; mask < (1 << m); mask++ {
        balance := make([]int, n)
        cnt := 0

        for i := 0; i < m; i++ {
            if (mask & (1 << i)) != 0 {
                from, to := requests[i][0], requests[i][1]
                balance[from]--
                balance[to]++
                cnt++
            }
        }

        valid := true
        for _, b := range balance {
            if b != 0 {
                valid = false
                break
            }
        }

        if valid && cnt > max {
            max = cnt
        }
    }

    return max
}