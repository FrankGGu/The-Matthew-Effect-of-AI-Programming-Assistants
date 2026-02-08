func threeConsecutiveOdds(arr []int) bool {
	n := len(arr)
	if n < 3 {
		return false
	}

	for i := 0; i <= n-3; i++ {
		if arr[i]%2 != 0 && arr[i+1]%2 != 0 && arr[i+2]%2 != 0 {
			return true
		}
	}

	return false
}