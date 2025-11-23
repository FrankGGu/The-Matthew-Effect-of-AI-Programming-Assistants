func maxStudents(seats [][]byte) int {
    m, n := len(seats), len(seats[0])
    dp := make([]int, 1<<n)
    for i := 0; i < m; i++ {
        current := make([]int, 1<<n)
        for mask := 0; mask < 1<<n; mask++ {
            valid := true
            for j := 0; j < n; j++ {
                if (mask>>j)&1 == 1 {
                    if seats[i][j] == '#' {
                        valid = false
                        break
                    }
                    if j > 0 && (mask>>(j-1))&1 == 1 {
                        valid = false
                        break
                    }
                }
            }
            if !valid {
                continue
            }
            cnt := bits.OnesCount(uint(mask))
            if i == 0 {
                current[mask] = cnt
                continue
            }
            maxPrev := 0
            for prevMask := 0; prevMask < 1<<n; prevMask++ {
                if dp[prevMask] > maxPrev {
                    conflict := false
                    for j := 0; j < n; j++ {
                        if (mask>>j)&1 == 1 {
                            if j > 0 && (prevMask>>(j-1))&1 == 1 {
                                conflict = true
                                break
                            }
                            if j < n-1 && (prevMask>>(j+1))&1 == 1 {
                                conflict = true
                                break
                            }
                        }
                    }
                    if !conflict {
                        maxPrev = dp[prevMask]
                    }
                }
            }
            current[mask] = maxPrev + cnt
        }
        dp = current
    }
    max := 0
    for _, val := range dp {
        if val > max {
            max = val
        }
    }
    return max
}