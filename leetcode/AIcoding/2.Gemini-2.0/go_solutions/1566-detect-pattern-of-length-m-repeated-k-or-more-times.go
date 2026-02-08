func containsPattern(arr []int, m int, k int) bool {
	n := len(arr)
	for i := 0; i <= n-m*k; i++ {
		count := 1
		for j := i + m; j <= n-m; j += m {
			match := true
			for l := 0; l < m; l++ {
				if arr[i+l] != arr[j+l] {
					match = false
					break
				}
			}
			if match {
				count++
			} else {
				break
			}
		}
		if count >= k {
			return true
		}
	}
	return false
}