func minimizeSum(nums []int) int {
	for i := range nums {
		for nums[i] >= 10 {
			sum := 0
			temp := nums[i]
			for temp > 0 {
				sum += temp % 10
				temp /= 10
			}
			nums[i] = sum
		}
	}

	minVal := nums[0]
	for _, num := range nums {
		if num < minVal {
			minVal = num
		}
	}
	return minVal
}