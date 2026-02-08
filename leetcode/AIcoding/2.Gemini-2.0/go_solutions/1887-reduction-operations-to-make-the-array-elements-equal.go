import "sort"

func reductionOperations(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	ans := 0
	count := 0
	for i := 1; i < n; i++ {
		if nums[i] != nums[i-1] {
			count++
		}
		ans += count
	}
	return ans
}