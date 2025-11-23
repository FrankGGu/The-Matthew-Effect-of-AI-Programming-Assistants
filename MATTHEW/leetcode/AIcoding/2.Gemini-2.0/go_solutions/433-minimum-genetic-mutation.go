func minMutation(start string, end string, bank []string) int {
	queue := []string{start}
	visited := map[string]bool{start: true}
	mutations := 0

	for len(queue) > 0 {
		levelSize := len(queue)
		for i := 0; i < levelSize; i++ {
			curr := queue[0]
			queue = queue[1:]

			if curr == end {
				return mutations
			}

			for _, gene := range bank {
				if !visited[gene] && isValidMutation(curr, gene) {
					queue = append(queue, gene)
					visited[gene] = true
				}
			}
		}
		mutations++
	}

	return -1
}

func isValidMutation(s1 string, s2 string) bool {
	diff := 0
	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			diff++
		}
	}
	return diff == 1
}