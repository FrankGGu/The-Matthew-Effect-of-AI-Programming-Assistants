import "sort"

func wiggleSort(nums []int) {
	n := len(nums)
	temp := make([]int, n)
	copy(temp, nums)
	sort.Ints(temp)

	mid := (n + 1) / 2
	j := n - 1
	for i := mid - 1; i >= 0; i-- {
		nums[j] = temp[i]
		j -= 2
	}

	j = n - 2
	for i := n - 1; i >= mid; i-- {
		nums[j] = temp[i]
		j -= 2
	}
}