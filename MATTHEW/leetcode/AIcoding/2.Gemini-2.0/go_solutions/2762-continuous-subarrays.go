func continuousSubarrays(nums []int) int64 {
	n := len(nums)
	ans := int64(0)
	left := 0
	for right := 0; right < n; right++ {
		for !isContinuous(nums[left : right+1]) {
			left++
		}
		ans += int64(right - left + 1)
	}
	return ans
}

func isContinuous(arr []int) bool {
	if len(arr) <= 1 {
		return true
	}
	maxVal := arr[0]
	minVal := arr[0]
	for _, num := range arr {
		if num > maxVal {
			maxVal = num
		}
		if num < minVal {
			minVal = num
		}
	}
	return maxVal-minVal <= 2
}