import "sort"

func minimumCost(nums []int) int {
	n := len(nums)
	a := make([]int, 0)
	for i := 1; i < n; i++ {
		a = append(a, nums[i])
	}
	sort.Ints(a)
	return nums[0] + a[0] + a[1]
}