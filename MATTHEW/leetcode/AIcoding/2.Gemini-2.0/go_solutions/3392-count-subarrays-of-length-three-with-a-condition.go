func countGoodSubarrays(arr []int, k int) int64 {
	n := len(arr)
	count := int64(0)
	for i := 0; i <= n-3; i++ {
		if abs(arr[i]-arr[i+1]) <= k && abs(arr[i+1]-arr[i+2]) <= k && abs(arr[i]-arr[i+2]) <= k {
			count++
		}
	}
	return count
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}