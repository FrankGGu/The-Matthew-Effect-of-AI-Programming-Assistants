func minSwaps(grid [][]int) int {
    n := len(grid)
    rows := make([]int, n)

    for i := 0; i < n; i++ {
        cnt := 0
        for j := n - 1; j >= 0 && grid[i][j] == 0; j-- {
            cnt++
        }
        rows[i] = cnt
    }

    swaps := 0
    for i := 0; i < n; i++ {
        if rows[i] < n-i-1 {
            j := i
            for j < n && rows[j] < n-i-1 {
                j++
            }
            if j == n {
                return -1
            }
            for k := j; k > i; k-- {
                rows[k], rows[k-1] = rows[k-1], rows[k]
                swaps++
            }
        }
    }

    return swaps
}