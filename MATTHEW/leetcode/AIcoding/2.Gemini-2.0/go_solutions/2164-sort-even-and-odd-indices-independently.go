import "sort"

func sortEvenOdd(nums []int) []int {
	even := make([]int, 0)
	odd := make([]int, 0)

	for i := 0; i < len(nums); i++ {
		if i%2 == 0 {
			even = append(even, nums[i])
		} else {
			odd = append(odd, nums[i])
		}
	}

	sort.Ints(even)
	sort.Sort(sort.Reverse(sort.IntSlice(odd)))

	evenIdx := 0
	oddIdx := 0
	for i := 0; i < len(nums); i++ {
		if i%2 == 0 {
			nums[i] = even[evenIdx]
			evenIdx++
		} else {
			nums[i] = odd[oddIdx]
			oddIdx++
		}
	}

	return nums
}