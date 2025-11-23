package main

func maxSideLength(mat [][]int, threshold int) int {
    m, n := len(mat), len(mat[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            prefix[i+1][j+1] = mat[i][j] + prefix[i][j+1] + prefix[i+1][j] - prefix[i][j]
        }
    }
    left, right := 1, min(m, n)
    ans := 0
    for left <= right {
        mid := (left + right) / 2
        found := false
        for i := mid; i <= m; i++ {
            for j := mid; j <= n; j++ {
                total := prefix[i][j] - prefix[i-mid][j] - prefix[i][j-mid] + prefix[i-mid][j-mid]
                if total <= threshold {
                    found = true
                    break
                }
            }
            if found {
                break
            }
        }
        if found {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}