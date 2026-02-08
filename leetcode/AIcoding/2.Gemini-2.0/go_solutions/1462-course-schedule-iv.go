func checkIfPrerequisite(numCourses int, prerequisites [][]int, queries [][]int) []bool {
	graph := make([][]int, numCourses)
	inDegree := make([]int, numCourses)
	isPrerequisite := make([][]bool, numCourses)
	for i := 0; i < numCourses; i++ {
		isPrerequisite[i] = make([]bool, numCourses)
	}

	for _, p := range prerequisites {
		graph[p[0]] = append(graph[p[0]], p[1])
		inDegree[p[1]]++
	}

	queue := []int{}
	for i := 0; i < numCourses; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	for len(queue) > 0 {
		course := queue[0]
		queue = queue[1:]

		for _, nextCourse := range graph[course] {
			isPrerequisite[course][nextCourse] = true
			for i := 0; i < numCourses; i++ {
				if isPrerequisite[i][course] {
					isPrerequisite[i][nextCourse] = true
				}
			}

			inDegree[nextCourse]--
			if inDegree[nextCourse] == 0 {
				queue = append(queue, nextCourse)
			}
		}
	}

	result := make([]bool, len(queries))
	for i, q := range queries {
		result[i] = isPrerequisite[q[0]][q[1]]
	}

	return result
}