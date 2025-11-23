func racecar(target int) int {
	q := [][]int{{0, 1, 0}}
	visited := map[string]bool{"0,1": true}

	for len(q) > 0 {
		curr := q[0]
		q = q[1:]
		pos, speed, steps := curr[0], curr[1], curr[2]

		if pos == target {
			return steps
		}

		nextPos := pos + speed
		nextSpeed := speed * 2
		nextKey := fmt.Sprintf("%d,%d", nextPos, nextSpeed)

		if abs(nextPos-target) < target && !visited[nextKey] {
			q = append(q, []int{nextPos, nextSpeed, steps + 1})
			visited[nextKey] = true
		}

		if (pos+speed > target && speed > 0) || (pos+speed < target && speed < 0) {
			nextSpeed := -1
			if speed > 0 {
				nextSpeed = -1
			} else {
				nextSpeed = 1
			}

			nextKey := fmt.Sprintf("%d,%d", pos, nextSpeed)
			if !visited[nextKey] {
				q = append(q, []int{pos, nextSpeed, steps + 1})
				visited[nextKey] = true
			}
		}
	}

	return -1
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}