func strangePrinterII(h [][]int, x int, y int) bool {
    if h[x][y] == 0 {
        return false
    }
    for i := 0; i < len(h); i++ {
        for j := 0; j < len(h[0]); j++ {
            if h[i][j] > 0 && (i != x || j != y) {
                return true
            }
        }
    }
    return false
}

func canPrint(h [][]int, x int, y int) bool {
    if h[x][y] == 0 {
        return true
    }
    h[x][y] = 0
    res := false
    for i := 0; i < len(h); i++ {
        for j := 0; j < len(h[0]); j++ {
            if canPrint(h, i, j) {
                res = true
            }
        }
    }
    h[x][y] = 1
    return res
}

func minPrint(h [][]int) int {
    cnt := 0
    for i := 0; i < len(h); i++ {
        for j := 0; j < len(h[0]); j++ {
            if h[i][j] > 0 {
                cnt++
                canPrint(h, i, j)
            }
        }
    }
    return cnt
}

func strangePrinterII(h [][]int) int {
    return minPrint(h)
}