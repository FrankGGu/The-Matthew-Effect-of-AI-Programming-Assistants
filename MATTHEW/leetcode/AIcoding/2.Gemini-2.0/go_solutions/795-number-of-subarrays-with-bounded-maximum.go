func numSubarrayBoundedMax(nums []int, left int, right int) int {
	ans := 0
	start := -1
	end := -1
	for i, num := range nums {
		if num >= left && num <= right {
			end = i
			ans += end - start
		} else if num < left {
			if end != -1 {
				ans += end - start
			}
		} else {
			start = i
			end = -1
		}
	}
	return ans
}