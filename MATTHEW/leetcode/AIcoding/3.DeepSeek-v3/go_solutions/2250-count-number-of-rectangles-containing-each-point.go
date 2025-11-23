import (
	"sort"
)

func countRectangles(rectangles [][]int, points [][]int) []int {
    // Group rectangles by their y-coordinate
    yToXs := make(map[int][]int)
    for _, rect := range rectangles {
        x, y := rect[0], rect[1]
        yToXs[y] = append(yToXs[y], x)
    }

    // Sort the x-coordinates for each y-coordinate
    for y := range yToXs {
        sort.Ints(yToXs[y])
    }

    // Get all unique y-coordinates and sort them
    ys := make([]int, 0, len(yToXs))
    for y := range yToXs {
        ys = append(ys, y)
    }
    sort.Ints(ys)

    res := make([]int, len(points))
    for i, point := range points {
        x, y := point[0], point[1]
        count := 0

        // Find the first y in ys >= point's y
        idx := sort.Search(len(ys), func(i int) bool {
            return ys[i] >= y
        })

        // For each y >= point's y, count the x's >= point's x
        for j := idx; j < len(ys); j++ {
            currentY := ys[j]
            xs := yToXs[currentY]
            // Find the first x in xs >= point's x
            xIdx := sort.Search(len(xs), func(i int) bool {
                return xs[i] >= x
            })
            count += len(xs) - xIdx
        }
        res[i] = count
    }
    return res
}