func smallestString(s string, a int, b int) string {
	n := len(s)
	visited := make(map[string]bool)
	queue := []string{s}
	visited[s] = true
	ans := s

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if curr < ans {
			ans = curr
		}

		add := make([]byte, n)
		for i := 0; i < n; i++ {
			add[i] = curr[i]
			if i%2 == 1 {
				add[i] = byte(((int(add[i]-'0') + a) % 10) + '0')
			}
		}
		addStr := string(add)
		if !visited[addStr] {
			visited[addStr] = true
			queue = append(queue, addStr)
		}

		rotate := make([]byte, n)
		for i := 0; i < n; i++ {
			rotate[(i+b)%n] = curr[i]
		}
		rotateStr := string(rotate)
		if !visited[rotateStr] {
			visited[rotateStr] = true
			queue = append(queue, rotateStr)
		}
	}

	return ans
}