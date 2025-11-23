import "container/list"

func shortestPathAllKeys(grid []string) int {
	m, n := len(grid), len(grid[0])
	var startX, startY int
	keyCount := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == '@' {
				startX, startY = i, j
			} else if grid[i][j] >= 'a' && grid[i][j] <= 'f' {
				keyCount++
			}
		}
	}

	q := list.New()
	q.PushBack([3]int{startX, startY, 0})
	visited := make(map[[3]int]bool)
	visited[[3]int{startX, startY, 0}] = true

	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	steps := 0

	for q.Len() > 0 {
		size := q.Len()
		for i := 0; i < size; i++ {
			curr := q.Front()
			q.Remove(curr)
			currArr := curr.Value.([3]int)
			x, y, keys := currArr[0], currArr[1], currArr[2]

			if keys == (1<<keyCount)-1 {
				return steps
			}

			for _, dir := range directions {
				newX, newY := x+dir[0], y+dir[1]

				if newX < 0 || newX >= m || newY < 0 || newY >= n || grid[newX][newY] == '#' {
					continue
				}

				newKeys := keys
				if grid[newX][newY] >= 'a' && grid[newX][newY] <= 'f' {
					keyIndex := grid[newX][newY] - 'a'
					newKeys |= (1 << keyIndex)
				}

				if grid[newX][newY] >= 'A' && grid[newX][newY] <= 'F' {
					lockIndex := grid[newX][newY] - 'A'
					if (keys & (1 << lockIndex)) == 0 {
						continue
					}
				}

				newState := [3]int{newX, newY, newKeys}
				if !visited[newState] {
					visited[newState] = true
					q.PushBack(newState)
				}
			}
		}
		steps++
	}

	return -1
}