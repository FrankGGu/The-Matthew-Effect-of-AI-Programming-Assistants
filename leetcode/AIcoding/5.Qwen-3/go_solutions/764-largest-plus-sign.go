package main

func orderOfLargestPlusSign(mat [][]int) int {
    n := len(mat)
    m := len(mat[0])
    maxLen := 0
    left := make([][]int, n)
    right := make([][]int, n)
    up := make([][]int, n)
    down := make([][]int, n)

    for i := 0; i < n; i++ {
        left[i] = make([]int, m)
        right[i] = make([]int, m)
        up[i] = make([]int, m)
        down[i] = make([]int, m)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if mat[i][j] == 1 {
                left[i][j] = 1
                if j > 0 {
                    left[i][j] += left[i][j-1]
                }
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := m - 1; j >= 0; j-- {
            if mat[i][j] == 1 {
                right[i][j] = 1
                if j < m-1 {
                    right[i][j] += right[i][j+1]
                }
            }
        }
    }

    for j := 0; j < m; j++ {
        for i := 0; i < n; i++ {
            if mat[i][j] == 1 {
                up[i][j] = 1
                if i > 0 {
                    up[i][j] += up[i-1][j]
                }
            }
        }
    }

    for j := 0; j < m; j++ {
        for i := n - 1; i >= 0; i-- {
            if mat[i][j] == 1 {
                down[i][j] = 1
                if i < n-1 {
                    down[i][j] += down[i+1][j]
                }
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if mat[i][j] == 1 {
                current := min(left[i][j], right[i][j], up[i][j], down[i][j])
                if current > maxLen {
                    maxLen = current
                }
            }
        }
    }

    return maxLen
}

func min(a, b, c, d int) int {
    if a < b {
        b = a
    }
    if c < b {
        b = c
    }
    if d < b {
        b = d
    }
    return b
}