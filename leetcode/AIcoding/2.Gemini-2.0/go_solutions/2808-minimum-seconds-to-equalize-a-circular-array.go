func minimumSeconds(nums []int) int {
	n := len(nums)
	pos := make(map[int][]int)
	for i, num := range nums {
		pos[num] = append(pos[num], i)
	}

	ans := n
	for _, p := range pos {
		maxDiff := 0
		for i := 0; i < len(p); i++ {
			diff := 0
			if i == len(p)-1 {
				diff = p[0] + n - p[i]
			} else {
				diff = p[i+1] - p[i]
			}
			if diff > maxDiff {
				maxDiff = diff
			}
		}
		seconds := maxDiff / 2
		if seconds < ans {
			ans = seconds
		}
	}

	return ans
}