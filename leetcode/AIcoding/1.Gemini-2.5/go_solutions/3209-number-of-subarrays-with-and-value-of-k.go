func subarraysWithAndValueK(nums []int, k int) int {
	ans := 0
	currentANDs := make(map[int]int)

	for _, num := range nums {
		nextANDs := make(map[int]int)

		nextANDs[num] = 1

		for val, count := range currentANDs {
			nextANDs[val&num] += count
		}

		for val, count := range nextANDs {
			if val == k {
				ans += count
			}
		}

		currentANDs = nextANDs
	}

	return ans
}