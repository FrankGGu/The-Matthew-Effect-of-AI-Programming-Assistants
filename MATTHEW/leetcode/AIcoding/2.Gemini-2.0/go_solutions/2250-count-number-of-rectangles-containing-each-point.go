import "sort"

func countRectangles(rectangles [][]int, points [][]int) []int {
	n := len(points)
	ans := make([]int, n)
	for i := range points {
		count := 0
		for _, rect := range rectangles {
			if rect[0] >= points[i][0] && rect[1] >= points[i][1] {
				count++
			}
		}
		ans[i] = count
	}
	return ans
}

func countRectanglesOptimized(rectangles [][]int, points [][]int) []int {
	heights := make(map[int][]int)
	for _, rect := range rectangles {
		heights[rect[1]] = append(heights[rect[1]], rect[0])
	}

	for h := range heights {
		sort.Ints(heights[h])
	}

	ans := make([]int, len(points))
	for i, point := range points {
		x, y := point[0], point[1]
		count := 0
		for h := y; h <= 100; h++ {
			if rects, ok := heights[h]; ok {
				l := sort.SearchInts(rects, x)
				count += len(rects) - l
			}
		}
		ans[i] = count
	}
	return ans
}