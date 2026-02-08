func minimumIndex(nums []int) int {
	n := len(nums)
	totalCount := make(map[int]int)
	for _, num := range nums {
		totalCount[num]++
	}

	leftCount := make(map[int]int)
	for i := 0; i < n-1; i++ {
		leftCount[nums[i]]++
		if 2*leftCount[nums[i]] > (i+1) && 2*(totalCount[nums[i]]-leftCount[nums[i]]) > (n-i-1) {
			return i
		}
	}
	return -1
}