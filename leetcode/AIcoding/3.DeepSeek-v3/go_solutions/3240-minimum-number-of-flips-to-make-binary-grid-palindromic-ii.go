func minFlips(mat [][]int) int {
    m, n := len(mat), len(mat[0])
    res := math.MaxInt32

    for mask := 0; mask < (1 << n); mask++ {
        flip := 0
        temp := make([][]int, m)
        for i := range temp {
            temp[i] = make([]int, n)
            copy(temp[i], mat[i])
        }

        for j := 0; j < n; j++ {
            if (mask >> j) & 1 == 1 {
                flip++
                temp[0][j] ^= 1
                if m > 1 {
                    temp[1][j] ^= 1
                }
                if j > 0 {
                    temp[0][j-1] ^= 1
                }
                if j < n-1 {
                    temp[0][j+1] ^= 1
                }
            }
        }

        for i := 1; i < m; i++ {
            for j := 0; j < n; j++ {
                if temp[i-1][j] == 1 {
                    flip++
                    temp[i][j] ^= 1
                    if i < m-1 {
                        temp[i+1][j] ^= 1
                    }
                    if j > 0 {
                        temp[i][j-1] ^= 1
                    }
                    if j < n-1 {
                        temp[i][j+1] ^= 1
                    }
                }
            }
        }

        valid := true
        for j := 0; j < n; j++ {
            if temp[m-1][j] == 1 {
                valid = false
                break
            }
        }

        if valid && flip < res {
            res = flip
        }
    }

    if res == math.MaxInt32 {
        return -1
    }
    return res
}