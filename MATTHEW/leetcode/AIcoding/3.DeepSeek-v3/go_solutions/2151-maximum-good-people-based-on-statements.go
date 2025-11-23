func maximumGood(statements [][]int) int {
    n := len(statements)
    maxGood := 0

    for mask := 0; mask < (1 << n); mask++ {
        valid := true
        goodCount := 0

        for i := 0; i < n && valid; i++ {
            if (mask & (1 << i)) == 0 {
                continue
            }
            goodCount++

            for j := 0; j < n && valid; j++ {
                if statements[i][j] == 2 {
                    continue
                }
                expected := (mask >> j) & 1
                if statements[i][j] != expected {
                    valid = false
                }
            }
        }

        if valid && goodCount > maxGood {
            maxGood = goodCount
        }
    }

    return maxGood
}