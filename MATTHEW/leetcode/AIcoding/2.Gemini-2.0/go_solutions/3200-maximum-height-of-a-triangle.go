func largestTriangleArea(points [][]int) float64 {
	n := len(points)
	maxArea := 0.0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				area := 0.5 * abs(float64(points[i][0]*(points[j][1]-points[k][1]) + points[j][0]*(points[k][1]-points[i][1]) + points[k][0]*(points[i][1]-points[j][1])))
				if area > maxArea {
					maxArea = area
				}
			}
		}
	}
	return maxArea
}

func abs(x float64) float64 {
	if x < 0 {
		return -x
	}
	return x
}