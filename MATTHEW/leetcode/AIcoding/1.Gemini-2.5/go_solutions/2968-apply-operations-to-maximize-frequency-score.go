import (
	"sort"
)

func maxFrequency(nums []int, k int) int {
	sort.Ints(nums)

	var currentSum int64
	left := 0
	maxFreq := 0
	n := len(nums)

	for right := 0; right < n; right++ {
		currentSum += int64(nums[right])

		// The cost to make all elements in nums[left...right] equal to nums[right]
		// is (right - left + 1) * nums[right] - currentSum
		// We need this cost to be <= k
		for (int64(right-left+1)*int64(nums[right]))-currentSum > int64(k) {
			currentSum -= int64(nums[left])
			left++
		}

		// Update maxFreq with the current window size
		maxFreq = max(maxFreq, right-left+1)
	}

	return maxFreq
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}