package main

import (
	"container/list"
	"sort"
)

type Tree struct {
	x, y, h int
}

type Point struct {
	x, y, steps int
}

var dx = []int{-1, 1, 0, 0}
var dy = []int{0, 0, -1, 1}

func cutOffTree(forest [][]int) int {
	m := len(forest)
	if m == 0 {
		return 0
	}
	n := len(forest[0])
	if n == 0 {
		return 0
	}

	trees := []Tree{}
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if forest[r][c] > 1 {
				trees = append(trees, Tree{r, c, forest[r][c]})
			}
		}
	}

	sort.Slice(trees, func(i, j int) bool {
		return trees[i].h < trees[j].h
	})

	totalSteps := 0
	currX, currY := 0, 0

	for _, tree := range trees {
		steps := bfs(forest, currX, currY, tree.x, tree.y, m, n)
		if steps == -1 {
			return -1
		}
		totalSteps += steps
		currX, currY = tree.x, tree.y
	}

	return totalSteps
}

func bfs(forest [][]int, startX, startY, targetX, targetY, m, n int) int {
	if startX == targetX && startY == targetY {
		return 0
	}

	queue := list.New()
	queue.PushBack(Point{startX, startY, 0})

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}
	visited[startX][startY] = true

	for queue.Len() > 0 {
		e := queue.Front()
		queue.Remove(e)
		p := e.Value.(Point)

		for i := 0; i < 4; i++ {
			nx, ny := p.x+dx[i], p.y+dy[i]

			if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && forest[nx][ny] >= 1 {
				if nx == targetX && ny == targetY {
					return p.steps + 1
				}
				visited[nx][ny] = true
				queue.PushBack(Point{nx, ny, p.steps + 1})
			}
		}
	}
	return -1
}