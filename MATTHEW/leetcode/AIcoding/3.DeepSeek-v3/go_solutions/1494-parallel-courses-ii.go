func minNumberOfSemesters(n int, relations [][]int, k int) int {
    pre := make([]int, n)
    for _, r := range relations {
        u, v := r[0]-1, r[1]-1
        pre[v] |= 1 << u
    }

    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = n
    }
    dp[0] = 0

    for mask := 0; mask < (1 << n); mask++ {
        available := 0
        for i := 0; i < n; i++ {
            if mask&(1<<i) == 0 && (pre[i]&mask == pre[i]) {
                available |= 1 << i
            }
        }

        for course := available; course > 0; course = (course - 1) & available {
            if bits.OnesCount(uint(course)) <= k {
                nextMask := mask | course
                if dp[nextMask] > dp[mask]+1 {
                    dp[nextMask] = dp[mask] + 1
                }
            }
        }
    }

    return dp[(1<<n)-1]
}