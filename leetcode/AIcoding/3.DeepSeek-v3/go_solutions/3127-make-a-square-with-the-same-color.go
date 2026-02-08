func canMakeSquare(grid [][]byte) bool {
    for i := 0; i < 2; i++ {
        for j := 0; j < 2; j++ {
            w, b := 0, 0
            for di := 0; di < 2; di++ {
                for dj := 0; dj < 2; dj++ {
                    if grid[i+di][j+dj] == 'W' {
                        w++
                    } else {
                        b++
                    }
                }
            }
            if w >= 3 || b >= 3 {
                return true
            }
        }
    }
    return false
}