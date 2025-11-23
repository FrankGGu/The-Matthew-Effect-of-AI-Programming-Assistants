import "sort"

func largestSumAfterKNegations(nums []int, k int) int {
	sort.Ints(nums)
	for i := 0; i < len(nums) && k > 0; i++ {
		if nums[i] < 0 {
			nums[i] = -nums[i]
			k--
		} else {
			break
		}
	}
	if k > 0 && k%2 == 1 {
		sort.Ints(nums)
		nums[0] = -nums[0]
	}
	sum := 0
	for _, num := range nums {
		sum += num
	}
	return sum
}