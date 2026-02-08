func minJumps(arr []int) int {
	n := len(arr)
	if n <= 1 {
		return 0
	}

	adj := make(map[int][]int)
	for i, v := range arr {
		adj[v] = append(adj[v], i)
	}

	q := []int{0}
	visited := make([]bool, n)
	visited[0] = true
	steps := 0

	for len(q) > 0 {
		size := len(q)
		for i := 0; i < size; i++ {
			curr := q[0]
			q = q[1:]

			if curr == n-1 {
				return steps
			}

			for _, neighbor := range adj[arr[curr]] {
				if !visited[neighbor] {
					visited[neighbor] = true
					q = append(q, neighbor)
				}
			}
			delete(adj, arr[curr])

			if curr+1 < n && !visited[curr+1] {
				visited[curr+1] = true
				q = append(q, curr+1)
			}

			if curr-1 >= 0 && !visited[curr-1] {
				visited[curr-1] = true
				q = append(q, curr-1)
			}
		}
		steps++
	}

	return -1
}