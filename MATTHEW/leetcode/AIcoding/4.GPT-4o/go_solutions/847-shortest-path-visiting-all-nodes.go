import "math"

func shortestPathLength(graph [][]int) int {
	n := len(graph)
	if n == 1 {
		return 0
	}
	visited := (1 << n) - 1
	queue := make([][2]int, 0)
	for i := 0; i < n; i++ {
		queue = append(queue, [2]int{i, 1 << i})
	}
	steps := 0
	seen := make(map[[2]int]bool)

	for len(queue) > 0 {
		for size := len(queue); size > 0; size-- {
			node, mask := queue[0][0], queue[0][1]
			queue = queue[1:]
			if mask == visited {
				return steps
			}
			for _, neighbor := range graph[node] {
				newMask := mask | (1 << neighbor)
				if !seen[[2]int{neighbor, newMask}] {
					seen[[2]int{neighbor, newMask}] = true
					queue = append(queue, [2]int{neighbor, newMask})
				}
			}
		}
		steps++
	}
	return -1
}