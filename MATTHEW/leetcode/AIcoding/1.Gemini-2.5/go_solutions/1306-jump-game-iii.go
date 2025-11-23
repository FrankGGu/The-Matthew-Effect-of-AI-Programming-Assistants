func canReach(arr []int, start int) bool {
	n := len(arr)
	visited := make([]bool, n)

	queue := []int{start}
	visited[start] = true

	for len(queue) > 0 {
		idx := queue[0]
		queue = queue[1:]

		if arr[idx] == 0 {
			return true
		}

		// Explore left jump
		leftJump := idx - arr[idx]
		if leftJump >= 0 && !visited[leftJump] {
			visited[leftJump] = true
			queue = append(queue, leftJump)
		}

		// Explore right jump
		rightJump := idx + arr[idx]
		if right