package main

import (
	"container/list"
	"math"
)

func minimumObstacles(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32
		}
	}

	dist[0][0] = 0

	q := list.New()
	q.PushFront([]int{0, 0})

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		curr := e.Value.([]int)
		r, c := curr[0], curr[1]

		if r == m-1 && c == n-1 {
			return dist[r][c]
		}

		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				weight := grid[nr][nc]
				if dist[r][c]+weight < dist[nr][nc] {
					dist[nr][nc] = dist[r][c] + weight
					if weight == 0 {
						q.PushFront([]int{nr, nc})
					} else { // weight == 1
						q.PushBack([]int{nr, nc})
					}
				}
			}
		}
	}

	return dist[m-1][n-1]
}