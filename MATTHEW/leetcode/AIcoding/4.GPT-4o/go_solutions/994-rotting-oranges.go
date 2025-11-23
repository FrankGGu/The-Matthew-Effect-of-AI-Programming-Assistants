package main

import (
	"container/list"
)

func orangesRotting(grid [][]int) int {
	rows, cols := len(grid), len(grid[0])
	queue := list.New()
	rottenCount, freshCount := 0, 0

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] == 2 {
				queue.PushBack([2]int{r, c})
				rottenCount++
			} else if grid[r][c] == 1 {
				freshCount++
			}
		}
	}

	if freshCount == 0 {
		return 0
	}

	directions := [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
	minutes := 0

	for queue.Len() > 0 {
		for i := 0; i < queue.Len(); i++ {
			pos := queue.Remove(queue.Front()).([2]int)
			for _, dir := range directions {
				r, c := pos[0]+dir[0], pos[1]+dir[1]
				if r >= 0 && r < rows && c >= 0 && c < cols && grid[r][c] == 1 {
					grid[r][c] = 2
					queue.PushBack([2]int{r, c})
					rottenCount++
					freshCount--
				}
			}
		}
		if queue.Len() > 0 {
			minutes++
		}
	}

	if freshCount > 0 {
		return -1
	}
	return minutes
}