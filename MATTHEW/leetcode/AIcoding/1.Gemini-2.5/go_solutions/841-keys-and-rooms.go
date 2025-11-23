func canVisitAllRooms(rooms [][]int) bool {
	n := len(rooms)
	visited := make([]bool, n)
	queue := []int{}
	visitedCount := 0

	queue = append(queue, 0)
	visited[0] = true
	visitedCount = 1

	for len(queue) > 0 {
		currentRoom := queue[0]
		queue = queue[1:]

		for _, nextRoom := range rooms[currentRoom] {
			if !visited[nextRoom] {
				visited[nextRoom] = true
				visitedCount++
				queue = append(queue, nextRoom)
			}
		}
	}

	return visitedCount == n
}