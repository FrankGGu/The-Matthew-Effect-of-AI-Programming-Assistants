func closestMeetingNode(edges []int, node1 int, node2 int) int {
	n := len(edges)
	dist1 := make([]int, n)
	dist2 := make([]int, n)
	for i := 0; i < n; i++ {
		dist1[i] = -1
		dist2[i] = -1
	}

	q := []int{node1}
	dist1[node1] = 0
	for len(q) > 0 {
		u := q[0]
		q = q[1:]
		v := edges[u]
		if v != -1 && dist1[v] == -1 {
			dist1[v] = dist1[u] + 1
			q = append(q, v)
		}
	}

	q = []int{node2}
	dist2[node2] = 0
	for len(q) > 0 {
		u := q[0]
		q = q[1:]
		v := edges[u]
		if v != -1 && dist2[v] == -1 {
			dist2[v] = dist2[u] + 1
			q = append(q, v)
		}
	}

	ans := -1
	minDist := int(1e9)
	for i := 0; i < n; i++ {
		if dist1[i] != -1 && dist2[i] != -1 {
			maxDist := max(dist1[i], dist2[i])
			if maxDist < minDist {
				minDist = maxDist
				ans = i
			}
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}