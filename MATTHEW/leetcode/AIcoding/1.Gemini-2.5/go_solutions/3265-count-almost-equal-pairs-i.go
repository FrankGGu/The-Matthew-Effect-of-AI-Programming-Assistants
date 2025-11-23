import "math"

func countAlmostEqualPairs(nums []int, k int) int {
	count := 0
	n := len(nums)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if int(math.Abs(float64(nums[i]-nums[j]))) <= k {
				count++
			}
		}
	}
	return count
}