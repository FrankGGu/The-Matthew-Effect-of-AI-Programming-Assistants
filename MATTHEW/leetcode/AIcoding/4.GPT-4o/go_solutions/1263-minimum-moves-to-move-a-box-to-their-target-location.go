package main

import "math"

type Point struct {
	x, y int
}

func minPushBox(box []int, target []int, grid [][]byte) int {
	start := Point{box[0], box[1]}
	tgt := Point{target[0], target[1]}
	visited := make(map[Point]bool)
	queue := []struct {
		box, player Point
		steps       int
	}{{start, Point{0, 0}, 0}}
	visited[start] = true

	directions := []Point{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if curr.box == tgt {
			return curr.steps
		}

		for _, dir := range directions {
			newBox := Point{curr.box.x + dir.x, curr.box.y + dir.y}
			if !isValid(newBox, grid) || newBox == curr.player {
				continue
			}

			if !isValid(Point{curr.box.x - dir.x, curr.box.y - dir.y}, grid) {
				continue
			}

			if !visited[newBox] {
				visited[newBox] = true
				queue = append(queue, struct {
					box, player Point
					steps       int
				}{newBox, curr.box, curr.steps + 1})
			}
		}
	}
	return -1
}

func isValid(p Point, grid [][]byte) bool {
	return p.x >= 0 && p.x < len(grid) && p.y >= 0 && p.y < len(grid[0]) && grid[p.x][p.y] != '#'
}