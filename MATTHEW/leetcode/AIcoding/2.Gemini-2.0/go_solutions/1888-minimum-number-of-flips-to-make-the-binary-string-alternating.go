func minFlips(s string) int {
	n := len(s)
	s = s + s
	pattern1 := ""
	pattern2 := ""
	for i := 0; i < 2*n; i++ {
		if i%2 == 0 {
			pattern1 += "0"
			pattern2 += "1"
		} else {
			pattern1 += "1"
			pattern2 += "0"
		}
	}
	flips1 := 0
	flips2 := 0
	minFlips := n
	for i := 0; i < 2*n; i++ {
		if s[i] != pattern1[i] {
			flips1++
		}
		if s[i] != pattern2[i] {
			flips2++
		}
		if i >= n {
			if s[i-n] != pattern1[i-n] {
				flips1--
			}
			if s[i-n] != pattern2[i-n] {
				flips2--
			}
		}
		if i >= n-1 {
			minFlips = min(minFlips, min(flips1, flips2))
		}
	}
	return minFlips
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}