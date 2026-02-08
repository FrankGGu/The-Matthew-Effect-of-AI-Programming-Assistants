import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func solve(nums []int) int {
	n := len(nums)
	ans := math.MinInt32
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				sum := nums[i] + nums[j] + nums[k]
				ans = max(ans, sum)
			}
		}
	}
	return ans
}

func maximumValueSum(nums []int) int {
	return solve(nums)
}