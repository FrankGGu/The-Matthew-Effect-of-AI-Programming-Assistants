import "sort"

func minMaxPairSum(nums []int) int {
	sort.Ints(nums)

	maxPairSum := 0
	left := 0
	right := len(nums) - 1

	for left < right {
		currentPairSum := nums[left] + nums[right]
		if currentPairSum > maxPairSum {
			maxPairSum = currentPairSum
		}
		left++
		right--
	}

	return maxPairSum
}