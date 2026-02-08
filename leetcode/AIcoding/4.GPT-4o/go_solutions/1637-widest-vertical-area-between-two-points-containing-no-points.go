func maxWidthOfVerticalArea(points [][]int) int {
    n := len(points)
    xCoords := make([]int, n)

    for i := 0; i < n; i++ {
        xCoords[i] = points[i][0]
    }

    sort.Ints(xCoords)

    maxWidth := 0
    for i := 1; i < n; i++ {
        width := xCoords[i] - xCoords[i-1]
        if width > maxWidth {
            maxWidth = width
        }
    }

    return maxWidth
}