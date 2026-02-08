func minSwaps(nums []int) int {
	n := len(nums)
	ones := 0
	for _, num := range nums {
		if num == 1 {
			ones++
		}
	}

	if ones == 0 || ones == n {
		return 0
	}

	windowOnes := 0
	for i := 0; i < ones; i++ {
		if nums[i] == 1 {
			windowOnes++
		}
	}

	maxOnes := windowOnes
	for i := ones; i < n; i++ {
		if nums[i] == 1 {
			windowOnes++
		}
		if nums[i-ones] == 1 {
			windowOnes--
		}
		maxOnes = max(maxOnes, windowOnes)
	}

	return ones - maxOnes
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}