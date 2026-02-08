package main

func minSwaps(grid string) int {
    n := len(grid)
    rows := make([]int, n)

    for i := 0; i < n; i++ {
        count := 0
        for j := n - 1; j >= 0 && grid[i][j] == '0'; j-- {
            count++
        }
        rows[i] = count
    }

    res := 0
    for i := 0; i < n; i++ {
        target := n - 1 - i
        found := false
        for j := i; j < n; j++ {
            if rows[j] >= target {
                found = true
                break
            }
        }
        if !found {
            return -1
        }
        for j := i; j < n; j++ {
            if rows[j] >= target {
                for k := j; k > i; k-- {
                    rows[k], rows[k-1] = rows[k-1], rows[k]
                }
                break
            }
        }
        res++
    }
    return res
}