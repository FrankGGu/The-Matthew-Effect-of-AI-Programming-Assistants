func canReach(arr []int, start int) bool {
	n := len(arr)
	visited := make([]bool, n)
	queue := []int{start}
	visited[start] = true

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if arr[curr] == 0 {
			return true
		}

		next1 := curr + arr[curr]
		next2 := curr - arr[curr]

		if next1 >= 0 && next1 < n && !visited[next1] {
			queue = append(queue, next1)
			visited[next1] = true
		}

		if next2 >= 0 && next2 < n && !visited[next2] {
			queue = append(queue, next2)
			visited[next2] = true
		}
	}

	return false
}