func countPairs(timeSeries [][]int, duration int) int {
	ans := 0
	last := -1
	for _, t := range timeSeries {
		if t[0] > last {
			ans += duration
		} else {
			ans += t[0] + duration - last - 1
		}
		last = t[0] + duration - 1
	}
	return ans
}