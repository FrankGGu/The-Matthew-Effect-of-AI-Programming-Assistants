import "fmt"

func maxStudents(seats [][]byte) int {
	m := len(seats)
	n := len(seats[0])
	dp := make([]int, 1<<n)
	for i := range dp {
		dp[i] = -1
	}

	var isValid func(mask int) bool
	isValid = func(mask int) bool {
		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 1 {
				if seats[0][i] == '#' {
					return false
				}
				if i > 0 && (mask>>(i-1))&1 == 1 {
					return false
				}
			}
		}
		return true
	}

	for mask := 0; mask < (1 << n); mask++ {
		if isValid(mask) {
			count := 0
			for i := 0; i < n; i++ {
				if (mask>>i)&1 == 1 {
					count++
				}
			}
			dp[mask] = count
		}
	}

	for i := 1; i < m; i++ {
		newDp := make([]int, 1<<n)
		for j := range newDp {
			newDp[j] = -1
		}

		var isValidRow func(mask int) bool
		isValidRow = func(mask int) bool {
			for k := 0; k < n; k++ {
				if (mask>>k)&1 == 1 {
					if seats[i][k] == '#' {
						return false
					}
					if k > 0 && (mask>>(k-1))&1 == 1 {
						return false
					}
				}
			}
			return true
		}

		for currentMask := 0; currentMask < (1 << n); currentMask++ {
			if !isValidRow(currentMask) {
				continue
			}
			count := 0
			for k := 0; k < n; k++ {
				if (currentMask>>k)&1 == 1 {
					count++
				}
			}

			for prevMask := 0; prevMask < (1 << n); prevMask++ {
				if dp[prevMask] == -1 {
					continue
				}

				valid := true
				for k := 0; k < n; k++ {
					if (currentMask>>k)&1 == 1 {
						if k > 0 && (prevMask>>(k-1))&1 == 1 {
							valid = false
							break
						}
						if (prevMask>>(k+1))&1 == 1 {
							valid = false
							break
						}
					}
				}

				if valid {
					newDp[currentMask] = max(newDp[currentMask], dp[prevMask]+count)
				}
			}
		}
		dp = newDp
	}

	ans := 0
	for _, val := range dp {
		ans = max(ans, val)
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}