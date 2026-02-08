func executeInstructions(n int, startPos []int, s string) []int {
	m := len(s)
	ans := make([]int, m)

	for i := 0; i < m; i++ {
		currentR := startPos[0]
		currentC := startPos[1]
		count := 0

		for j := i; j < m; j++ {
			instruction := s[j]

			switch instruction {
			case 'L':
				currentC--
			case 'R':
				currentC++
			case 'U':
				currentR--
			case 'D':
				currentR++
			}

			if currentR < 0 || currentR >= n || currentC < 0 || currentC >= n {
				break
			}
			count++
		}
		ans[i] = count
	}

	return ans
}