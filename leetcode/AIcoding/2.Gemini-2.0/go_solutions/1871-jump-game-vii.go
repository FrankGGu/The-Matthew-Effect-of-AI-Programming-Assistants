func canReach(s string, minJump int, maxJump int) bool {
	n := len(s)
	if s[n-1] == '1' {
		return false
	}

	q := []int{0}
	visited := make([]bool, n)
	visited[0] = true
	reachable := 0

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]

		for i := max(curr+minJump, reachable+1); i <= min(curr+maxJump, n-1); i++ {
			if s[i] == '0' && !visited[i] {
				q = append(q, i)
				visited[i] = true
			}
		}
		reachable = curr + maxJump
		if reachable >= n-1 {
			return true
		}
	}

	return visited[n-1]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}