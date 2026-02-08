package main

func maxMarkedIndices(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	i, j := 0, (n + 1) / 2
	res := 0
	for i < (n + 1) / 2 && j < n {
		if nums[j] >= 2 * nums[i] {
			res++
			i++
		}
		j++
	}
	return res
}