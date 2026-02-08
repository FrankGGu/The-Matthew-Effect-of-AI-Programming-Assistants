func maxTrailingZeros(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    rowFactors := make([][2]int, m)
    colFactors := make([][2]int, n)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            count2, count5 := countFactors(grid[i][j])
            rowFactors[i][0] += count2
            rowFactors[i][1] += count5
            colFactors[j][0] += count2
            colFactors[j][1] += count5
        }
    }

    maxZeros := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            total2 := rowFactors[i][0] + colFactors[j][0] - countFactors(grid[i][j])[0]
            total5 := rowFactors[i][1] + colFactors[j][1] - countFactors(grid[i][j])[1]
            maxZeros = max(maxZeros, min(total2, total5))
        }
    }

    return maxZeros
}

func countFactors(num int) (int, int) {
    count2, count5 := 0, 0
    for num%2 == 0 && num > 0 {
        count2++
        num /= 2
    }
    for num%5 == 0 && num > 0 {
        count5++
        num /= 5
    }
    return count2, count5
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}