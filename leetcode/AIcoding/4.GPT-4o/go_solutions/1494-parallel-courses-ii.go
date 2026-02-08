func minNumberOfSemesters(n int, relations [][]int, k int) int {
	inDegree := make([]int, n)
	graph := make([][]int, n)
	for _, r := range relations {
		graph[r[0]-1] = append(graph[r[0]-1], r[1]-1)
		inDegree[r[1]-1]++
	}

	queue := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	semesters := 0
	for len(queue) > 0 {
		semesters++
		nextQueue := []int{}
		taken := 0
		for _, course := range queue {
			if taken >= k {
				break
			}
			nextQueue = append(nextQueue, course)
			taken++
			for _, nextCourse := range graph[course] {
				inDegree[nextCourse]--
				if inDegree[nextCourse] == 0 {
					nextQueue = append(nextQueue, nextCourse)
				}
			}
		}
		queue = nextQueue
		for i := 0; i < len(queue); i++ {
			if taken >= k {
				break
			}
			if inDegree[queue[i]] == 0 {
				nextQueue = append(nextQueue, queue[i])
				taken++
			}
		}
		queue = nextQueue
	}

	return semesters
}