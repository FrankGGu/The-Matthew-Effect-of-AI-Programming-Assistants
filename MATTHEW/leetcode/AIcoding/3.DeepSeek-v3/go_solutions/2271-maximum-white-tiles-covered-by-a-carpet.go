func maximumWhiteTiles(tiles [][]int, carpetLen int) int {
    sort.Slice(tiles, func(i, j int) bool {
        return tiles[i][0] < tiles[j][0]
    })

    n := len(tiles)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + tiles[i][1] - tiles[i][0] + 1
    }

    maxCover := 0
    for i := 0; i < n; i++ {
        start := tiles[i][0]
        end := start + carpetLen - 1
        left, right := i, n-1
        best := i
        for left <= right {
            mid := left + (right - left) / 2
            if tiles[mid][1] <= end {
                best = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        cover := prefix[best+1] - prefix[i]
        if best+1 < n {
            cover += max(0, end - tiles[best+1][0] + 1)
        }
        if cover > maxCover {
            maxCover = cover
        }
    }
    return maxCover
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}