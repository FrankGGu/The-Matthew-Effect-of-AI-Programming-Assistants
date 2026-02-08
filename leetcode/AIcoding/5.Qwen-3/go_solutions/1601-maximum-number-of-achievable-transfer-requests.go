package main

func maximumTransferRequests(beam []int, cnt []int, requests [][]int) int {
    n := len(requests)
    maxTransfer := 0

    for mask := 1; mask < 1<<n; mask++ {
        in := make([]int, len(beam))
        out := make([]int, len(beam))
        count := 0

        for i := 0; i < n; i++ {
            if (mask >> i) & 1 == 1 {
                count++
                u, v := requests[i][0], requests[i][1]
                in[v]++
                out[u]++
            }
        }

        valid := true
        for i := 0; i < len(beam); i++ {
            if in[i] != out[i] {
                valid = false
                break
            }
        }

        if valid {
            maxTransfer = max(maxTransfer, count)
        }
    }

    return maxTransfer
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}