func maximumGood(statements [][]int) int {
    n := len(statements)
    maxGood := 0

    for mask := 0; mask < (1 << n); mask++ {
        good := true
        count := 0

        for i := 0; i < n; i++ {
            if (mask>>i)&1 == 1 {
                count++
                for j := 0; j < n; j++ {
                    if statements[i][j] == 1 && (mask>>j)&1 == 0 {
                        good = false
                        break
                    } else if statements[i][j] == 2 && (mask>>j)&1 == 1 {
                        good = false
                        break
                    }
                }
            }
            if !good {
                break
            }
        }

        if good {
            maxGood = max(maxGood, count)
        }
    }

    return maxGood
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}