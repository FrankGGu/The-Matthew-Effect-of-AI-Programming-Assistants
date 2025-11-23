func countBlackBlocks(m int, n int, coordinates [][]int) []int64 {
    res := make([]int64, 5)
    blockCount := make(map[[2]int]int)

    for _, coord := range coordinates {
        x, y := coord[0], coord[1]
        for i := max(0, x-1); i <= min(m-2, x); i++ {
            for j := max(0, y-1); j <= min(n-2, y); j++ {
                blockCount[[2]int{i, j}]++
            }
        }
    }

    for _, cnt := range blockCount {
        res[cnt]++
    }

    total := int64(m-1) * int64(n-1)
    res[0] = total - int64(len(blockCount))
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}