import "sort"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxNumberOfMarkedIndices(nums []int) int {
	n := len(nums)
	sort.Ints(nums)
	i, j := 0, (n+1)/2
	count := 0
	for i < (n+1)/2 && j < n {
		if 2*nums[i] <= nums[j] {
			count += 2
			i++
			j++
		} else {
			j++
		}
	}
	return count
}