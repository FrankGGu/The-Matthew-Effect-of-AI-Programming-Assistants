func findTheString(lcp [][]int) string {
	n := len(lcp)
	res := make([]byte, n)
	char := byte('a')

	for i := 0; i < n; i++ {
		if res[i] == 0 {
			res[i] = char
			char++
		}
		for j := 0; j < n; j++ {
			if i == 0 && j == 0 {
				continue
			}

			if res[i] == res[j] {
				if i > 0 && j > 0 {
					if lcp[i-1][j-1] > 0 {
						if lcp[i][j] != lcp[i-1][j-1]-1 {
							return ""
						}
					} else {
						if lcp[i][j] != 0 {
							return ""
						}
					}
				} else if i == 0 && j > 0 {
					if lcp[i][j] != lcp[i][j-1]-1 {
						return ""
					}
				} else if i > 0 && j == 0 {
					if lcp[i][j] != lcp[i-1][j]-1 {
						return ""
					}
				}
			} else {
				if lcp[i][j] != 0 {
					return ""
				}
			}

			if i > 0 && j > 0 && lcp[i][j] > 0 && res[i] != res[j] {
				return ""
			}

			if i == 0 && j == 0 && lcp[i][j] != n {
				return ""
			}
		}
	}

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			expectedLcp := 0
			if res[i] == res[j] {
				if i > 0 && j > 0 {
					expectedLcp = lcp[i-1][j-1] - 1
				} else if i == 0 && j > 0 {
					expectedLcp = lcp[i][j-1] - 1
				} else if i > 0 && j == 0 {
					expectedLcp = lcp[i-1][j] - 1
				} else {
					expectedLcp = n
				}
				k := 0
				for i+k < n && j+k < n && res[i+k] == res[j+k] {
					k++
				}

				if i > 0 && j > 0 {
					if res[i] == res[j] && res[i-1] == res[j-1]{
						if k != lcp[i][j]{
							return ""
						}
					}
				}
				if k != lcp[i][j] {
					return ""
				}
			} else {
				if lcp[i][j] != 0 {
					return ""
				}
			}
		}
	}

	return string(res)
}