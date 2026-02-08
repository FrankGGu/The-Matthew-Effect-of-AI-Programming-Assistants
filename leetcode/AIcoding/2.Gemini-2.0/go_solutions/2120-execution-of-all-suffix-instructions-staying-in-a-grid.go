func executeInstructions(n int, startPos []int, s string) []int {
	ans := make([]int, len(s))
	for i := 0; i < len(s); i++ {
		x := startPos[0]
		y := startPos[1]
		count := 0
		for j := i; j < len(s); j++ {
			if s[j] == 'R' {
				y++
			} else if s[j] == 'L' {
				y--
			} else if s[j] == 'U' {
				x--
			} else {
				x++
			}
			if x < 0 || x >= n || y < 0 || y >= n {
				break
			}
			count++
		}
		ans[i] = count
	}
	return ans
}