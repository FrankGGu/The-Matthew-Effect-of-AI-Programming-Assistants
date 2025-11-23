import "sort"

func minimumArrayLength(nums []int) int {
	sort.Ints(nums)
	minVal := nums[0]
	count := 0
	for _, num := range nums {
		if num%minVal == 0 {
			count++
		} else {
			return 1
		}
	}

	if count > (len(nums)+1)/2 {
		return count - (len(nums) - count)
	}
	return 1
}