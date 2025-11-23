import "sort"

func maxWidthOfVerticalArea(points [][]int) int {
    xs := make([]int, len(points))
    for i, p := range points {
        xs[i] = p[0]
    }
    sort.Ints(xs)
    maxWidth := 0
    for i := 1; i < len(xs); i++ {
        width := xs[i] - xs[i-1]
        if width > maxWidth {
            maxWidth = width
        }
    }
    return maxWidth
}