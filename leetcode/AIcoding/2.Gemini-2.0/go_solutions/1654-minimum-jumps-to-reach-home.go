func minimumJumps(forbidden []int, a int, b int, x int) int {
	forbiddenSet := make(map[int]bool)
	for _, f := range forbidden {
		forbiddenSet[f] = true
	}

	q := [][]int{{0, 0, 0}} // pos, steps, lastJumpedBack
	visited := make(map[string]bool)
	visited["0_0"] = true

	maxReach := 2000 + a + b

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		pos, steps, jumpedBack := curr[0], curr[1], curr[2]

		if pos == x {
			return steps
		}

		forward := pos + a
		if forward <= maxReach && !forbiddenSet[forward] {
			key := fmt.Sprintf("%d_%d", forward, 0)
			if !visited[key] {
				visited[key] = true
				q = append(q, []int{forward, steps + 1, 0})
			}
		}

		if jumpedBack == 0 {
			backward := pos - b
			if backward >= 0 && !forbiddenSet[backward] {
				key := fmt.Sprintf("%d_%d", backward, 1)
				if !visited[key] {
					visited[key] = true
					q = append(q, []int{backward, steps + 1, 1})
				}
			}
		}
	}

	return -1
}

import "fmt"