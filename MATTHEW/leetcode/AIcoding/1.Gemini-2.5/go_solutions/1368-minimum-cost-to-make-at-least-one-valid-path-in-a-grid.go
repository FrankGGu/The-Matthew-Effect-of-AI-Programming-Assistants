package main

import (
	"container/list"
	"math"
)

type Cell struct {
	r, c int
}

func minCost(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	dist := make([][]int, m)
	for i := range dist {
		dist[i] = make([]int, n)
		for j := range dist[i] {
			dist[i][j] = math.MaxInt32
		}
	}

	// Directions: right, left, down, up
	// Mapped to grid[r][c] values: 1, 2, 3, 4
	dr := []int{0, 0, 1, -1}
	dc := []int{1, -1, 0, 0}

	q := list.New()

	dist[0][0] = 0
	q.PushFront(Cell{0, 0})

	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		curr := e.Value.(Cell)
		r, c := curr.r, curr.c

		for i := 0; i < 4; i++ { // Iterate through 4 possible directions
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				cost := 1
				if grid[r][c] == i+1 {
					cost = 0
				}

				if dist[r][c]+cost < dist[nr][nc] {
					dist[nr][nc] = dist[r][c] + cost
					if cost == 0 {
						q.PushFront(Cell{nr, nc})
					} else {
						q.PushBack(Cell{nr, nc})
					}
				}
			}
		}
	}

	return dist[m-1][n-1]
}