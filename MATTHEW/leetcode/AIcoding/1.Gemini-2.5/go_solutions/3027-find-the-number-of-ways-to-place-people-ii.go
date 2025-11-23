import "sort"

func numberOfWays(points [][]int) int {
    // Sort points: primary key x ascending, secondary key y descending.
    sort.Slice(points, func(a, b int) bool {
        if points[a][0] != points[b][0] {
            return points[a][0] < points