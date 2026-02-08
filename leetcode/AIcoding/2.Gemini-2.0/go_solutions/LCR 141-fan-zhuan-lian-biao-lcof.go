func trainingPlan(tasks [][]int, n int) []int {
	graph := make([][]int, n)
	inDegree := make([]int, n)
	for _, task := range tasks {
		preTask := task[0]
		postTask := task[1]
		graph[preTask] = append(graph[preTask], postTask)
		inDegree[postTask]++
	}

	queue := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	result := []int{}
	for len(queue) > 0 {
		task := queue[0]
		queue = queue[1:]
		result = append(result, task)

		for _, nextTask := range graph[task] {
			inDegree[nextTask]--
			if inDegree[nextTask] == 0 {
				queue = append(queue, nextTask)
			}
		}
	}

	return result
}