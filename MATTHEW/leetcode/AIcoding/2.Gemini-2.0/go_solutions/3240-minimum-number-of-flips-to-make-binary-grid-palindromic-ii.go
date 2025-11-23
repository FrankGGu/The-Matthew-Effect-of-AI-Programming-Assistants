import (
	"container/list"
)

func minFlips(grid [][]int) int {
	n := len(grid)
	start := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			start = (start << 1) | grid[i][j]
		}
	}

	target := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			target = (target << 1) | grid[n-1-i][n-1-j]
		}
	}

	q := list.New()
	q.PushBack(start)
	visited := make(map[int]int)
	visited[start] = 0

	for q.Len() > 0 {
		curr := q.Front()
		q.Remove(curr)
		state := curr.Value.(int)
		steps := visited[state]

		if state == target {
			return steps
		}

		for i := 0; i < n; i++ {
			for j := 0; j < n; j++ {
				newState := state
				for x := i; x <= i+1 && x < n; x++ {
					for y := j; y <= j+1 && y < n; y++ {
						index := x*n + y
						if (newState>>uint(n*n-1-index))&1 == 1 {
							newState &= ^(1 << uint(n*n-1-index))
						} else {
							newState |= (1 << uint(n*n-1-index))
						}
					}
				}

				if _, ok := visited[newState]; !ok {
					visited[newState] = steps + 1
					q.PushBack(newState)
				}
			}
		}
	}

	return -1
}