package main

func numberOfBeautifulIntegers(k int, queries []int) []int {
    var res []int
    for _, q := range queries {
        res = append(res, countBeautifulIntegers(q))
    }
    return res
}

func countBeautifulIntegers(n int) int {
    s := strconv.Itoa(n)
    nLen := len(s)
    dp := make([][2][2][10][10]int, nLen+1)
    for i := 0; i <= nLen; i++ {
        for j := 0; j < 2; j++ {
            for k := 0; k < 2; k++ {
                for l := 0; l < 10; l++ {
                    for m := 0; m < 10; m++ {
                        dp[i][j][k][l][m] = -1
                    }
                }
            }
        }
    }

    var dfs func(int, int, int, int, int, bool) int
    dfs = func(pos int, tight int, leadingZeros bool, evenCount int, oddCount int, isPrefix bool) int {
        if pos == len(s) {
            return 1
        }
        if dp[pos][tight][leadingZeros][evenCount][oddCount] != -1 {
            return dp[pos][tight][leadingZeros][evenCount][oddCount]
        }

        limit := 9
        if tight == 1 {
            limit = int(s[pos] - '0')
        }

        total := 0
        for d := 0; d <= limit; d++ {
            newTight := 0
            if tight == 1 && d == limit {
                newTight = 1
            }
            newLeadingZeros := leadingZeros && d == 0
            newEvenCount := evenCount
            newOddCount := oddCount
            if !newLeadingZeros {
                if d%2 == 0 {
                    newEvenCount++
                } else {
                    newOddCount++
                }
            }
            if newLeadingZeros {
                total += dfs(pos+1, newTight, newLeadingZeros, newEvenCount, newOddCount, isPrefix)
            } else {
                if isPrefix {
                    total += dfs(pos+1, newTight, newLeadingZeros, newEvenCount, newOddCount, true)
                } else {
                    if newEvenCount == newOddCount {
                        total += dfs(pos+1, newTight, newLeadingZeros, newEvenCount, newOddCount, false)
                    } else {
                        total += dfs(pos+1, newTight, newLeadingZeros, newEvenCount, newOddCount, false)
                    }
                }
            }
        }

        dp[pos][tight][leadingZeros][evenCount][oddCount] = total
        return total
    }

    return dfs(0, 1, true, 0, 0, false)
}