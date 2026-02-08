package main

func findOrder(numCourses int, prerequisites [][]int) []int {
	adj := make([][]int, numCourses)
	inDegree := make([]int, numCourses)

	for _, pre := range prerequisites {
		course := pre[0]
		prereq := pre[1]
		adj[prereq] = append(adj[prereq], course)
		inDegree[course]++
	}

	queue := []int{}
	for i := 0; i < numCourses; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	result := []int{}
	head := 0
	for head < len(queue) {
		curr := queue[head]
		head++
		result = append(result, curr)

		for _, neighbor := range adj[curr] {
			inDegree[neighbor]--
			if inDegree[neighbor] == 0 {
				queue = append(queue, neighbor)
			}
		}
	}

	if len(result) == numCourses {
		return result
	}
	return []int{}
}