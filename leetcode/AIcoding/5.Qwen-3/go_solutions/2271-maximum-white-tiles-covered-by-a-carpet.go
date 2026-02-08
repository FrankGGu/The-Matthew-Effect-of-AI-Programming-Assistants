package main

func maximumWhiteTiles(tiles [][]int, carpetLen int) int {
    sort.Slice(tiles, func(i, j int) bool {
        return tiles[i][0] < tiles[j][0]
    })

    n := len(tiles)
    res := 0
    j := 0
    covered := 0

    for i := 0; i < n; i++ {
        start, end := tiles[i][0], tiles[i][1]
        if j < n && tiles[j][0] <= start+carpetLen-1 {
            for j < n && tiles[j][0] <= start+carpetLen-1 {
                if tiles[j][1] < start+carpetLen {
                    covered += tiles[j][1] - tiles[j][0] + 1
                } else {
                    covered += start+carpetLen - tiles[j][0]
                }
                j++
            }
        }
        res = max(res, covered)
        if j < n && tiles[j][0] <= start+carpetLen-1 {
            covered -= tiles[i][1] - tiles[i][0] + 1
        } else {
            covered = 0
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}