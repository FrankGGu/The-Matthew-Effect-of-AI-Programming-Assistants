func getSubarrayBeauty(nums []int, k int, x int) []int {
	n := len(nums)
	result := make([]int, n-k+1)

	for i := 0; i <= n-k; i++ {
		subarray := nums[i : i+k]
		negatives := []int{}
		for _, num := range subarray {
			if num < 0 {
				negatives = append(negatives, num)
			}
		}

		if len(negatives) >= x {
			result[i] = negatives[x-1]
		} else {
			result[i] = 0
		}
	}

	return result
}