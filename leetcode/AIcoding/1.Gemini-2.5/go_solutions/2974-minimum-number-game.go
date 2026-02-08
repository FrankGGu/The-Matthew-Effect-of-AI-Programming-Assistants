import "sort"

func numberGame(nums []int) []int {
	sort.Ints(nums)

	n := len(nums)
	arr := make([]int, 0, n)

	for i := 0; i < n; i += 2 {
		// Alice picks nums[i]
		// Bob picks nums[i+1]
		// Append Bob's pick then Alice's pick
		arr = append(arr, nums[i+1], nums[i])
	}

	return arr
}