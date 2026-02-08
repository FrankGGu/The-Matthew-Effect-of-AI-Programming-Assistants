package main

func findAllPeople(n int, meetings [][]int, firstPerson int) []int {
	visited := make([]bool, n)
	visited[firstPerson] = true

	sort.Slice(meetings, func(i, j int) bool {
		return meetings[i][2] < meetings[j][2]
	})

	i := 0
	for i < len(meetings) {
		j := i
		for j < len(meetings) && meetings[j][2] == meetings[i][2] {
			j++
		}

		graph := make(map[int][]int)
		people := make(map[int]bool)

		for k := i; k < j; k++ {
			a, b := meetings[k][0], meetings[k][1]
			graph[a] = append(graph[a], b)
			graph[b] = append(graph[b], a)
			people[a] = true
			people[b] = true
		}

		queue := []int{}
		for person := range people {
			if visited[person] {
				queue = append(queue, person)
			}
		}

		for len(queue) > 0 {
			curr := queue[0]
			queue = queue[1:]
			for _, neighbor := range graph[curr] {
				if !visited[neighbor] {
					visited[neighbor] = true
					queue = append(queue, neighbor)
				}
			}
		}

		i = j
	}

	result := []int{}
	for i := 0; i < n; i++ {
		if visited[i] {
			result = append(result, i)
		}
	}

	return result
}