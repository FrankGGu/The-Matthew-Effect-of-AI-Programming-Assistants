func minDeletionSize(strs []string) int {
	n := len(strs)
	m := len(strs[0])
	ans := 0
	sorted := make([]bool, n-1)

	for j := 0; j < m; j++ {
		tempSorted := make([]bool, n-1)
		copy(tempSorted, sorted)

		del := false
		for i := 0; i < n-1; i++ {
			if !sorted[i] && strs[i][j] > strs[i+1][j] {
				ans++
				del = true
				break
			}
		}

		if !del {
			for i := 0; i < n-1; i++ {
				if strs[i][j] < strs[i+1][j] {
					tempSorted[i] = true
				}
			}
			sorted = tempSorted
		}
	}

	return ans
}