func calculateScore(s string, instructions []int) []int64 {
	n := len(s)
	m := len(instructions)
	score := make([]int64, m)
	visited := make([]bool, n)

	for i := 0; i < m; i++ {
		idx := instructions[i] - 1
		curr := 0
		if s[idx] == 'L' {
			j := idx - 1
			for j >= 0 {
				if !visited[j] {
					visited[j] = true
					curr = j + 1
					break
				}
				j--
			}
		} else {
			j := idx + 1
			for j < n {
				if !visited[j] {
					visited[j] = true
					curr = j + 1
					break
				}
				j++
			}
		}
		visited[idx] = true
		score[i] = int64(curr)
	}

	return score
}