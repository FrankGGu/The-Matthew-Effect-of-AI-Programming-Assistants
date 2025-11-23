package main

import (
	"sort"
)

type item struct {
	dist  int
	price int
	row   int
	col   int
}

func highestRankedKItems(grid [][]int, pricing []int, start []int, k int) [][]int {
	m, n := len(grid), len(grid[0])
	lower, upper := pricing[0], pricing[1]

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	items := []item{}
	queue := [][]int{{start[0], start[1], 0}} // {row, col, distance}
	visited[start[0]][start[1]] = true

	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	head := 0
	for head < len(queue) {
		curr := queue[head]
		head++
		r, c, dist := curr[0], curr[1], curr[2]

		if grid[r][c] >= lower && grid[r][c] <= upper {
			items = append(items, item{dist, grid[r][c], r, c})
		}

		for i := 0; i < 4; i++ {
			nr, nc := r+dr[i], c+dc[i]

			if nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && grid[nr][nc] != 0 {
				visited[nr][nc] = true
				queue = append(queue, []int{nr, nc, dist + 1})
			}
		}
	}

	sort.Slice(items, func(i, j int) bool {
		if items[i].dist != items[j].dist {
			return items[i].dist < items[j].dist
		}
		if items[i].price != items[j].price {
			return items[i].price < items[j].price
		}
		if items[i].row != items[j].row {
			return items[i].row < items[j].row
		}
		return items[i].col < items[j].col
	})

	result := make([][]int, 0, k)
	for i := 0; i < len(items) && i < k; i++ {
		result = append(result, []int{items[i].row, items[i].col})
	}

	return result
}