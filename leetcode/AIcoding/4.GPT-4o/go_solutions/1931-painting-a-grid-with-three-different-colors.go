func colorTheGrid(m int, n int) int {
    const mod int = 1e9 + 7
    if m > n {
        m, n = n, m
    }

    dp := make([]int, 1 << (2 * m))
    dp[0] = 1

    for i := 0; i < n; i++ {
        newDp := make([]int, 1 << (2 * m))
        for mask := 0; mask < (1 << (2 * m)); mask++ {
            if dp[mask] == 0 {
                continue
            }
            generateColors(mask, 0, 0, m, i, newDp, dp[mask], mod)
        }
        dp = newDp
    }

    result := 0
    for _, count := range dp {
        result = (result + count) % mod
    }
    return result
}

func generateColors(mask, pos, row, m, col int, newDp []int, count int, mod int) {
    if row == m {
        newDp[mask] = (newDp[mask] + count) % mod
        return
    }
    for c := 0; c < 3; c++ {
        if (mask >> (2 * row) & 3) == c || (row > 0 && (mask >> (2 * (row - 1)) & 3) == c) {
            continue
        }
        generateColors(mask|(c<<(2*row)), pos+1, row+1, m, col, newDp, count, mod)
    }
}