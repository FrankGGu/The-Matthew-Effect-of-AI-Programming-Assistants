func countPoints(points [][]int, queries [][]int) []int {
	ans := make([]int, len(queries))
	for i, query := range queries {
		count := 0
		for _, point := range points {
			x := point[0]
			y := point[1]
			xq := query[0]
			yq := query[1]
			r := query[2]
			if (x-xq)*(x-xq)+(y-yq)*(y-yq) <= r*r {
				count++
			}
		}
		ans[i] = count
	}
	return ans
}