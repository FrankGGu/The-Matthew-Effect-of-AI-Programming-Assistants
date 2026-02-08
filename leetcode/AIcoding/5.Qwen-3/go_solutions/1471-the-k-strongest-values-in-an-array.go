package main

func getStrongest(nums []int, k int) []int {
	sort.Ints(nums)
	n := len(nums)
	mid := nums[(n-1)/2]
	i, j := 0, n-1
	result := make([]int, 0, k)
	for len(result) < k {
		if abs(nums[i]) > abs(nums[j]) {
			result = append(result, nums[i])
			i++
		} else {
			result = append(result, nums[j])
			j--
		}
	}
	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}