package main

func getMaximumGenerated(n int) int {
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}

	nums := make([]int, n+1)
	nums[0] = 0
	nums[1] = 1

	maxVal := 1

	for i := 2; i <= n; i++ {
		if i%2 == 0 { // i is even
			nums[i] = nums[i/2]
		} else { // i is odd
			nums[i] = nums[i/2] + nums[i/2+1]
		}
		if nums[i] > maxVal {
			maxVal = nums[i]
		}
	}

	return maxVal
}