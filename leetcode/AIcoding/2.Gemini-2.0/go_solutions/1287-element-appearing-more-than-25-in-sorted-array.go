func findSpecialInteger(arr []int) int {
	n := len(arr)
	threshold := n / 4
	for i := 0; i < n-threshold; i++ {
		if arr[i] == arr[i+threshold] {
			return arr[i]
		}
	}
	return -1
}