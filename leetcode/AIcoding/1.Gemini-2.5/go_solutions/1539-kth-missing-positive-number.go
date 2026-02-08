func findKthPositive(arr []int, k int) int {
	for i := 0; i < len(arr); i++ {
		missingCount := arr[i] - (i + 1)
		if missingCount >= k {
			return arr[i] - (missingCount - k + 1)
		}
	}

	return k + len(arr)
}