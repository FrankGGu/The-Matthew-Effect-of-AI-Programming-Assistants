func openLock(deadends []string, target string) int {
	dead := make(map[string]bool)
	for _, d := range deadends {
		dead[d] = true
	}

	if dead["0000"] {
		return -1
	}

	queue := []string{"0000"}
	visited := make(map[string]bool)
	visited["0000"] = true
	steps := 0

	for len(queue) > 0 {
		size := len(queue)
		for i := 0; i < size; i++ {
			curr := queue[0]
			queue = queue[1:]

			if curr == target {
				return steps
			}

			for j := 0; j < 4; j++ {
				up := rotateUp(curr, j)
				down := rotateDown(curr, j)

				if !dead[up] && !visited[up] {
					queue = append(queue, up)
					visited[up] = true
				}

				if !dead[down] && !visited[down] {
					queue = append(queue, down)
					visited[down] = true
				}
			}
		}
		steps++
	}

	return -1
}

func rotateUp(s string, i int) string {
	r := []rune(s)
	if r[i] == '9' {
		r[i] = '0'
	} else {
		r[i]++
	}
	return string(r)
}

func rotateDown(s string, i int) string {
	r := []rune(s)
	if r[i] == '0' {
		r[i] = '9'
	} else {
		r[i]--
	}
	return string(r)
}