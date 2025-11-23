func maximumInvitations(favorite []int) int {
	n := len(favorite)
	indegrees := make([]int, n)
	for _, f := range favorite {
		indegrees[f]++
	}

	q := []int{}
	for i := 0; i < n; i++ {
		if indegrees[i] == 0 {
			q = append(q, i)
		}
	}

	depth := make([]int, n)
	for i := 0; i < n; i++ {
		depth[i] = 1
	}

	for len(q) > 0 {
		u := q[0]
		q = q[1:]
		v := favorite[u]
		depth[v] = max(depth[v], depth[u]+1)
		indegrees[v]--
		if indegrees[v] == 0 {
			q = append(q, v)
		}
	}

	cycleSum := 0
	chainSum := 0
	visited := make([]bool, n)

	for i := 0; i < n; i++ {
		if visited[i] || indegrees[i] == 0 {
			continue
		}
		j := i
		count := 0
		for !visited[j] {
			visited[j] = true
			j = favorite[j]
			count++
		}

		if i == j {
			cycleSum += count
		} else {
			chainSum += depth[i] + depth[favorite[i]]
		}
	}

	return max(cycleSum, chainSum/2)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}