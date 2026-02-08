func maximize(capacity int, plantTime []int, growTime []int) int {
	n := len(plantTime)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return growTime[indices[i]] > growTime[indices[j]]
	})

	ans := 0
	curPlant := 0

	for _, i := range indices {
		curPlant += plantTime[i]
		ans = max(ans, curPlant+growTime[i])
	}

	return ans + capacity
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}