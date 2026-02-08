func addRungs(rungs []int, dist int) int {
	count := 0
	prev := 0
	for _, rung := range rungs {
		diff := rung - prev
		if diff > dist {
			count += (diff - 1) / dist
		}
		prev = rung
	}
	return count
}