func robot(command string, obstacles [][]int, x int, y int) bool {
	px, py := 0, 0
	visited := make(map[string]bool)
	visited["0,0"] = true

	for i := 0; i < len(command); i++ {
		if command[i] == 'U' {
			py++
		} else {
			px++
		}
		visited[fmt.Sprintf("%d,%d", px, py)] = true
	}

	if px == 0 && py == 0 {
		if x == 0 && y == 0 {
			return true
		}
		return false
	}

	if x < 0 || y < 0 {
		return false
	}

	k := 0
	for {
		if px == 0 && py == 0 {
			break
		}
		dx := x - k*px
		dy := y - k*py

		if dx < 0 || dy < 0 {
			break
		}

		if dx == 0 && dy == 0 {
			if visited["0,0"] {
				goto ObstaclesCheck
			} else {
				break
			}
		}

		if visited[fmt.Sprintf("%d,%d", dx, dy)] {
			goto ObstaclesCheck
		} else {

		}

		k++
	}

	return false

ObstaclesCheck:

	for _, obstacle := range obstacles {
		ox, oy := obstacle[0], obstacle[1]
		if ox > x || oy > y {
			continue
		}

		k := 0
		for {
			if px == 0 && py == 0 {
				break
			}
			dx := ox - k*px
			dy := oy - k*py

			if dx < 0 || dy < 0 {
				break
			}

			if dx == 0 && dy == 0 {
				if visited["0,0"] {
					return false
				} else {
					break
				}
			}

			if visited[fmt.Sprintf("%d,%d", dx, dy)] {
				return false
			} else {

			}
			k++
		}

	}
	return true
}

import "fmt"