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

			neighbors := getNeighbors(curr)
			for _, neighbor := range neighbors {
				if !dead[neighbor] && !visited[neighbor] {
					queue = append(queue, neighbor)
					visited[neighbor] = true
				}
			}
		}
		steps++
	}

	return -1
}

func getNeighbors(s string) []string {
	neighbors := make([]string, 0)
	for i := 0; i < 4; i++ {
		digit := int(s[i] - '0')
		up := (digit + 1) % 10
		down := (digit + 9) % 10

		upStr := s[:i] + string(rune(up+'0')) + s[i+1:]
		downStr := s[:i] + string(rune(down+'0')) + s[i+1:]

		neighbors = append(neighbors, upStr, downStr)
	}
	return neighbors
}

func main() {}