func maxStudents(seats [][]byte) int {
    m, n := len(seats), len(seats[0])
    dp := make([]int, 1<<n)
    for i := 0; i < m; i++ {
        for mask := 0; mask < (1 << n); mask++ {
            if isValid(seats[i], mask) {
                dp[mask] = max(dp[mask], countBits(mask))
            }
        }
        for mask := (1 << n) - 1; mask >= 0; mask-- {
            if dp[mask] > 0 {
                for nextMask := 0; nextMask < (1 << n); nextMask++ {
                    if isValid(seats[i], nextMask) && (mask&nextMask) == 0 {
                        dp[nextMask] = max(dp[nextMask], dp[mask] + countBits(nextMask))
                    }
                }
            }
        }
    }
    ans := 0
    for _, v := range dp {
        ans = max(ans, v)
    }
    return ans
}

func isValid(seatRow []byte, mask int) bool {
    for j := 0; j < len(seatRow); j++ {
        if (mask&(1<<j)) != 0 {
            if seatRow[j] == '#' || (j > 0 && (mask&(1<<(j-1))) != 0) || (j < len(seatRow)-1 && (mask&(1<<(j+1))) != 0) {
                return false
            }
        }
    }
    return true
}

func countBits(mask int) int {
    count := 0
    for mask > 0 {
        count += mask & 1
        mask >>= 1
    }
    return count
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}