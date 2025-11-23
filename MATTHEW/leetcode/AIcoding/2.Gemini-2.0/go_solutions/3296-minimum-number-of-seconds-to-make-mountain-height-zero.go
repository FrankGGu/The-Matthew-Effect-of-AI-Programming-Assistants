func minimumSeconds(nums []int) int {
	n := len(nums)
	first := make(map[int]int)
	last := make(map[int]int)
	for i := 0; i < n; i++ {
		if _, ok := first[nums[i]]; !ok {
			first[nums[i]] = i
		}
		last[nums[i]] = i
	}

	maxDist := make(map[int]int)
	for num := range first {
		dist := 0
		for i := first[num]; i < last[num]; i++ {
			dist = max(dist, i-first[num])
		}

		dist = max(dist, n-last[num]+first[num])
		maxDist[num] = dist
	}

	ans := n
	for num := range first {
		ans = min(ans, maxDist[num])
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}