import "math"

func maxValueAfterReverse(nums []int) int {
	n := len(nums)
	sum := 0
	for i := 0; i < n-1; i++ {
		sum += abs(nums[i] - nums[i+1])
	}

	extra := 0
	minMax := math.MaxInt32
	maxMin := math.MinInt32
	for i := 0; i < n-1; i++ {
		extra = max(extra, abs(nums[0]-nums[i+1])-abs(nums[i]-nums[i+1]))
		extra = max(extra, abs(nums[n-1]-nums[i])-abs(nums[i]-nums[i+1]))
		minMax = min(minMax, max(nums[i], nums[i+1]))
		maxMin = max(maxMin, min(nums[i], nums[i+1]))
	}

	extra = max(extra, 2*(maxMin-minMax))
	return sum + extra
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}