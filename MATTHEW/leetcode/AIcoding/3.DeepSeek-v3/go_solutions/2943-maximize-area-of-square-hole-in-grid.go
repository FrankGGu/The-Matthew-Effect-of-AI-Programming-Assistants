func maximizeSquareHoleArea(n int, m int, hBars []int, vBars []int) int {
    maxH := maxConsecutive(hBars)
    maxV := maxConsecutive(vBars)
    minSide := min(maxH, maxV)
    return minSide * minSide
}

func maxConsecutive(bars []int) int {
    sort.Ints(bars)
    max := 1
    current := 1
    for i := 1; i < len(bars); i++ {
        if bars[i] == bars[i-1]+1 {
            current++
            if current > max {
                max = current
            }
        } else if bars[i] != bars[i-1] {
            current = 1
        }
    }
    return max + 1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}