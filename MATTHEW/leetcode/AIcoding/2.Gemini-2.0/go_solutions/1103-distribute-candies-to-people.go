func distributeCandies(candies int, num_people int) []int {
	res := make([]int, num_people)
	give := 1
	idx := 0
	for candies > 0 {
		res[idx] += min(candies, give)
		candies -= give
		give++
		idx = (idx + 1) % num_people
	}
	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}