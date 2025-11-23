func distributeCandies(candyType []int) int {
	m := make(map[int]bool)
	for _, t := range candyType {
		m[t] = true
	}
	if len(m) >= len(candyType)/2 {
		return len(candyType) / 2
	}
	return len(m)
}