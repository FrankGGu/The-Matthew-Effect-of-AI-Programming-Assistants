func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minimumSemesters(n int, dependencies [][]int, k int) int {
	inDegree := make([]int, n)
	graph := make([][]int, n)
	for _, dep := range dependencies {
		from, to := dep[0]-1, dep[1]-1
		graph[from] = append(graph[from], to)
		inDegree[to]++
	}

	q := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			q = append(q, i)
		}
	}

	semesters := 0
	completed := 0
	for len(q) > 0 {
		semesters++
		take := min(len(q), k)
		nextQ := []int{}
		takenCourses := []int{}
		for i := 0; i < take; i++ {
			takenCourses = append(takenCourses, q[i])
		}
		q = q[take:]
		for _, course := range takenCourses {
			completed++
			for _, neighbor := range graph[course] {
				inDegree[neighbor]--
				if inDegree[neighbor] == 0 {
					nextQ = append(nextQ, neighbor)
				}
			}
		}
		q = append(q, nextQ...)
	}

	if completed != n {
		return -1
	}

	return semesters
}