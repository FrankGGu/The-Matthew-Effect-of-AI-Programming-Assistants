func longestObstacleCourseAtEachPosition(obstacles []int) []int {
	n := len(obstacles)
	dp := make([]int, n)
	var lis []int

	for i := 0; i < n; i++ {
		pos := sort.Search(len(lis), func(j int) bool {
			return lis[j] > obstacles[i]
		})
		if pos < len(lis) {
			lis[pos] = obstacles[i]
		} else {
			lis = append(lis, obstacles[i])
		}
		dp[i] = pos + 1
	}
	return dp
}