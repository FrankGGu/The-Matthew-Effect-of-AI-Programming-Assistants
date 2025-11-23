import "math"

func minSubArrayLen(target int, nums []int) int {
	minLen := math.MaxInt32
	sum := 0
	left := 0

	for right := 0; right < len(nums); right++ {
		sum += nums[right]
		for sum >= target {
			minLen = int(math.Min(float64(minLen), float64(right-left+1)))
			sum -= nums[left]
			left++
		}
	}

	if minLen == math.MaxInt32 {
		return 0
	}
	return minLen
}