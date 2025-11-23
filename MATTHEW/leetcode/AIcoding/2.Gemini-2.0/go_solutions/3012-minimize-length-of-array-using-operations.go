func minimumArrayLength(nums []int) int {
	minVal := nums[0]
	count := 0
	for _, num := range nums {
		if num < minVal {
			minVal = num
		}
	}
	for _, num := range nums {
		if num == minVal {
			count++
		}
	}
	for _, num := range nums {
		if num%minVal != 0 {
			return 1
		}
	}
	if count > (len(nums)+1)/2 {
		return count
	}
	return (len(nums) + 1) / 2
}