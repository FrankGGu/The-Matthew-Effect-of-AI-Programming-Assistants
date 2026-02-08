package main

import (
	"container/list"
	"math"
)

type Pos struct {
	r, c int
}

func maximumSafenessFactor(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	safenessGrid := make([][]int, m)
	for i := range safenessGrid {
		safenessGrid[i] = make([]int, n)
		for j := range safenessGrid[i] {
			safenessGrid[i][j] = math.MaxInt32
		}
	}

	q := list.New()

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 1 {
				safenessGrid[r][c] = 0
				q.PushBack(Pos{r, c})
			}
		}
	}

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		curr := e.Value.(Pos)

		for i := 0; i < 4; i++ {
			nr, nc := curr.r+dr[i], curr.c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n {
				if safenessGrid[nr][nc] > safenessGrid[curr.r][curr.c]+1 {
					safenessGrid[nr][nc] = safenessGrid[curr.r][curr.c] + 1
					q.PushBack(Pos{nr, nc})
				}
			}
		}
	}

	low := 0
	high := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if safenessGrid[r][c] > high {
				high = safenessGrid[r][c]
			}
		}
	}

	ans := 0

	for low <= high {
		mid := low + (high-low)/2
		if canReach(safenessGrid, mid, m, n) {
			ans = mid
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	return ans
}

func canReach(safenessGrid [][]int, k int, m, n int) bool {
	if safenessGrid[0][0] < k || safenessGrid[m-1][n-1] < k {
		return false
	}

	q := list.New()
	q.PushBack(Pos{0, 0})

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}
	visited[0][0] = true

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	for q.Len() > 0 {
		e := q.Front()
		q.Remove(e)
		curr := e.Value.(Pos)

		if curr.r == m-1 && curr.c == n-1 {
			return true
		}

		for i := 0; i < 4; i++ {
			nr, nc := curr.r+dr[i], curr.c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] {
				if safenessGrid[nr][nc] >= k {
					visited[nr][nc] = true
					q.PushBack(Pos{nr, nc})
				}
			}
		}
	}

	return false
}