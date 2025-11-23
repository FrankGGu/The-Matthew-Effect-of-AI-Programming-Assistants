func firstMissingPositive(nums []int) int {
	n := len(nums)

	// 1. Check if 1 exists in the array. If not, you're done and 1 is the answer.
	exists := false
	for _, num := range nums {
		if num == 1 {
			exists = true
			break
		}
	}
	if !exists {
		return 1
	}

	// 2. Replace negative numbers, zeros,
	// and numbers larger than n by 1.
	// After this conversion, nums will contain
	// only positive numbers.
	for i := 0; i < n; i++ {
		if nums[i] <= 0 || nums[i] > n {
			nums[i] = 1
		}
	}

	// 3. Use the index as a hash key and number sign as a presence detector.
	// For example, if nums[1] is negative, that means that the number `1`
	// is present in the array.
	// If nums[2] is positive, the number 2 is missing.
	for i := 0; i < n; i++ {
		a := abs(nums[i])
		if a == n {
			nums[0] = -abs(nums[0])
		} else {
			nums[a] = -abs(nums[a])
		}
	}

	// 4. Now the index of the first positive number
	// is equal to the first missing positive.
	for i := 1; i < n; i++ {
		if nums[i] > 0 {
			return i
		}
	}

	if nums[0] > 0 {
		return n
	}

	return n + 1
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}