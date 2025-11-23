package main

import (
	"container/list"
)

type State struct {
	row, col, keys, steps int
}

func shortestPathAllKeys(grid []string) int {
	m := len(grid)
	n := len(grid[0])

	startR, startC := -1, -1
	numKeys := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == '@' {
				startR, startC = r, c
			} else if grid[r][c] >= 'a' && grid[r][c] <= 'f' {
				numKeys++
			}
		}
	}

	targetKeysMask := (1 << numKeys) - 1

	queue := list.New()
	queue.PushBack(State{startR, startC, 0, 0})

	visited := make([][][]bool, m)
	for i := range visited {
		visited[i] = make([][]bool, n)
		for j := range visited[i] {
			visited[i][j] = make([]bool, 1<<numKeys)
		}
	}

	visited[startR][startC][0] = true

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for queue.Len() > 0 {
		e := queue.Front()
		queue.Remove(e)
		curr := e.Value.(State)

		if curr.keys == targetKeysMask {
			return curr.steps
		}

		for i := 0; i < 4; i++ {
			nr, nc := curr.row+dr[i], curr.col+dc[i]
			newKeys := curr.keys

			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				char := grid[nr][nc]

				if char == '#' {
					continue
				}

				if char >= 'a' && char <= 'f' {
					newKeys |= (1 << (char - 'a'))
				} else if char >= 'A' && char <= 'F' {
					if (curr.keys>>(char-'A'))&1 == 0 {
						continue
					}
				}

				if !visited[nr][nc][newKeys] {
					visited[nr][nc][newKeys] = true
					queue.PushBack(State{nr, nc, newKeys, curr.steps + 1})
				}
			}
		}
	}

	return -1
}