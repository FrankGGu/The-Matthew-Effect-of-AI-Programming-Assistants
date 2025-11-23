func maxTrailingZeros(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    prefix2 := make([][]int, m+1)
    prefix5 := make([][]int, m+1)
    for i := range prefix2 {
        prefix2[i] = make([]int, n+1)
        prefix5[i] = make([]int, n+1)
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            num := grid[i-1][j-1]
            cnt2, cnt5 := countFactors(num)
            prefix2[i][j] = prefix2[i-1][j] + prefix2[i][j-1] - prefix2[i-1][j-1] + cnt2
            prefix5[i][j] = prefix5[i-1][j] + prefix5[i][j-1] - prefix5[i-1][j-1] + cnt5
        }
    }

    maxZeros := 0
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            left2 := prefix2[i][j] - prefix2[i-1][j]
            right2 := prefix2[i][n] - prefix2[i][j-1] - (prefix2[i-1][n] - prefix2[i-1][j-1])
            up2 := prefix2[i][j] - prefix2[i][j-1]
            down2 := prefix2[m][j] - prefix2[i-1][j] - (prefix2[m][j-1] - prefix2[i-1][j-1])

            left5 := prefix5[i][j] - prefix5[i-1][j]
            right5 := prefix5[i][n] - prefix5[i][j-1] - (prefix5[i-1][n] - prefix5[i-1][j-1])
            up5 := prefix5[i][j] - prefix5[i][j-1]
            down5 := prefix5[m][j] - prefix5[i-1][j] - (prefix5[m][j-1] - prefix5[i-1][j-1])

            maxZeros = max(maxZeros, min(left2+up2-left2, left5+up5-left5))
            maxZeros = max(maxZeros, min(left2+down2-left2, left5+down5-left5))
            maxZeros = max(maxZeros, min(right2+up2-right2, right5+up5-right5))
            maxZeros = max(maxZeros, min(right2+down2-right2, right5+down5-right5))
        }
    }
    return maxZeros
}

func countFactors(num int) (int, int) {
    cnt2, cnt5 := 0, 0
    for num%2 == 0 {
        cnt2++
        num /= 2
    }
    for num%5 == 0 {
        cnt5++
        num /= 5
    }
    return cnt2, cnt5
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}