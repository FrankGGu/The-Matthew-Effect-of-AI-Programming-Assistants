func waysToMakeFair(nums []int) int {
	n := len(nums)
	evenSum := 0
	oddSum := 0
	for i := 0; i < n; i++ {
		if i%2 == 0 {
			evenSum += nums[i]
		} else {
			oddSum += nums[i]
		}
	}

	evenBefore := 0
	oddBefore := 0
	count := 0
	for i := 0; i < n; i++ {
		if i%2 == 0 {
			evenSum -= nums[i]
			if evenBefore+oddSum == oddBefore+evenSum {
				count++
			}
			evenBefore += nums[i]
		} else {
			oddSum -= nums[i]
			if evenBefore+oddSum == oddBefore+evenSum {
				count++
			}
			oddBefore += nums[i]
		}
	}
	return count
}