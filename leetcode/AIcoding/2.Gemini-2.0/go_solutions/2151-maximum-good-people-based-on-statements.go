func maximumGood(statements [][]int) int {
	n := len(statements)
	ans := 0
	for mask := 0; mask < (1 << n); mask++ {
		good := 0
		valid := true
		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 1 {
				good++
				for j := 0; j < n; j++ {
					if statements[i][j] == 2 {
						continue
					}
					if statements[i][j] != ((mask>>j)&1) {
						valid = false
						break
					}
				}
				if !valid {
					break
				}
			}
		}
		if valid {
			ans = max(ans, good)
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}