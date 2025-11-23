func getDistances(nums []int, k int) []int64 {
	n := len(nums)
	if n == 0 || k > n {
		return []int64{}
	}

	result := make([]int64, 0, n-k+1)
	freq :=