package main

import (
	"math"
)

func updateMatrix(mat [][]int) [][]int {
	rows := len(mat)
	if rows == 0 {
		return [][]int{}
	}
	cols := len(mat[0])

	dist := make([][]int, rows)
	queue := [][]int{}

	for r := 0; r < rows; r++ {
		dist[r] = make([]int, cols)
		for c := 0; c < cols; c++ {
			if mat[r][c] == 0 {
				dist[r][c] = 0
				queue = append(queue, []int{r, c})
			} else {
				dist[r][c] = math.MaxInt32
			}
		}
	}

	dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

	head := 0
	for head < len(queue) {
		curr := queue[head]
		head++
		r, c := curr[0], curr[1]

		for _, dir := range dirs {
			nr, nc := r+dir[0], c+dir[1]

			if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
				if dist[nr][nc] > dist[r][c]+1 {
					dist[nr][nc] = dist[r][c] + 1
					queue = append(queue, []int{nr, nc})
				}
			}
		}
	}

	return dist
}