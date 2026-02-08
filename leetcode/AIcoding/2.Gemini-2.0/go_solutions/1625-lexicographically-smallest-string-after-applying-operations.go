func findLexSmallestString(s string, a int, b int) string {
	n := len(s)
	visited := make(map[string]bool)
	q := []string{s}
	visited[s] = true
	ans := s

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		if curr < ans {
			ans = curr
		}

		rotate := curr[b:] + curr[:b]

		add := make([]byte, n)
		for i := 0; i < n; i++ {
			if i%2 == 1 {
				digit := int(curr[i] - '0')
				newDigit := (digit + a) % 10
				add[i] = byte(newDigit + '0')
			} else {
				add[i] = curr[i]
			}
		}
		addStr := string(add)

		if !visited[rotate] {
			q = append(q, rotate)
			visited[rotate] = true
		}

		if !visited[addStr] {
			q = append(q, addStr)
			visited[addStr] = true
		}
	}

	return ans
}