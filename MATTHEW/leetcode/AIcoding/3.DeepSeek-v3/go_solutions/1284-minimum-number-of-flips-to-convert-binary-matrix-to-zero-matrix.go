func minFlips(mat [][]int) int {
    m, n := len(mat), len(mat[0])
    size := m * n
    minFlips := -1

    for mask := 0; mask < (1 << size); mask++ {
        flipCount := 0
        temp := make([][]int, m)
        for i := range temp {
            temp[i] = make([]int, n)
            copy(temp[i], mat[i])
        }

        for i := 0; i < size; i++ {
            if (mask >> i) & 1 == 1 {
                flipCount++
                x, y := i / n, i % n
                flip(temp, x, y)
                if x > 0 {
                    flip(temp, x-1, y)
                }
                if x < m-1 {
                    flip(temp, x+1, y)
                }
                if y > 0 {
                    flip(temp, x, y-1)
                }
                if y < n-1 {
                    flip(temp, x, y+1)
                }
            }
        }

        if isZeroMatrix(temp) {
            if minFlips == -1 || flipCount < minFlips {
                minFlips = flipCount
            }
        }
    }

    return minFlips
}

func flip(mat [][]int, x, y int) {
    mat[x][y] ^= 1
}

func isZeroMatrix(mat [][]int) bool {
    for _, row := range mat {
        for _, val := range row {
            if val != 0 {
                return false
            }
        }
    }
    return true
}