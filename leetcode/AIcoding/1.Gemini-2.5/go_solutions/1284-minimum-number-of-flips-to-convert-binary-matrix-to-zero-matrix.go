package main

import (
	"container/list"
)

func minFlips(mat [][]int) int {
	R := len(mat)
	C := len(mat[0])

	initialState := 0
	for i := 0; i < R; i++ {
		for j := 0; j < C; j++ {
			if mat[i][j] == 1 {
				initialState |= (1 << (i*C + j))
			}
		}
	}

	queue := list.New()
	queue.PushBack(struct{ state, steps int }{initialState, 0})
	visited := make(map[int]bool)
	visited[initialState] = true

	dr := []int{0, 0, 0, 1, -1}
	dc := []int{0, 1, -1, 0, 0}

	for queue.Len() > 0 {
		curr := queue.Remove(queue.Front()).(struct{ state, steps int })

		if curr.state == 0 {
			return curr.steps
		}

		for r := 0; r < R; r++ {
			for c := 0; c < C; c++ {
				nextState := curr.state

				for k := 0; k < 5; k++ {
					nr, nc := r+dr[k], c+dc[k]

					if nr >= 0 && nr < R && nc >= 0 && nc < C {
						bitPos := nr*C + nc
						nextState ^= (1 << bitPos)
					}
				}

				if !visited[nextState] {
					visited[nextState] = true
					queue.PushBack(struct{ state, steps int }{nextState, curr.steps + 1})
				}
			}
		}
	}

	return -1
}