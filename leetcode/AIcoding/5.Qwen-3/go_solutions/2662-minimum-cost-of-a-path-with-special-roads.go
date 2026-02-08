package main

import (
	"container/heap"
)

type Point struct {
	x, y int
}

type QueueItem struct {
	cost int
	p    Point
}

type PriorityQueue []*QueueItem

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].cost < pq[j].cost
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(*QueueItem)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func minimumCostToCatchAllRats(startX, startY, endX, endY int, specialRoads [][]int) int {
	dirs := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
	visited := make(map[Point]bool)
	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, &QueueItem{0, Point{startX, startY}})
	visited[Point{startX, startY}] = true

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(*QueueItem)
		if curr.p.x == endX && curr.p.y == endY {
			return curr.cost
		}
		for _, d := range dirs {
			nx, ny := curr.p.x+d[0], curr.p.y+d[1]
			if nx >= 0 && ny >= 0 && !visited[Point{nx, ny}] {
				visited[Point{nx, ny}] = true
				heap.Push(&pq, &QueueItem{curr.cost + 1, Point{nx, ny}})
			}
		}
		for i := 0; i < len(specialRoads); i += 2 {
			sx, sy, ex, ey := specialRoads[i][0], specialRoads[i][1], specialRoads[i+1][0], specialRoads[i+1][1]
			if curr.p.x == sx && curr.p.y == sy {
				if !visited[Point{ex, ey}] {
					visited[Point{ex, ey}] = true
					heap.Push(&pq, &QueueItem{curr.cost + 1, Point{ex, ey}})
				}
			}
			if curr.p.x == ex && curr.p.y == ey {
				if !visited[Point{sx, sy}] {
					visited[Point{sx, sy}] = true
					heap.Push(&pq, &QueueItem{curr.cost + 1, Point{sx, sy}})
				}
			}
		}
	}
	return -1
}