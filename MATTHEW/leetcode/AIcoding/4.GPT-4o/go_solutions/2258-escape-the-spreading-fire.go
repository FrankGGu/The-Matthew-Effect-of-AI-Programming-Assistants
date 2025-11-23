package main

import (
	"container/heap"
	"fmt"
)

type Point struct {
	x, y int
}

type MinHeap []Point

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].x < h[j].x || (h[i].x == h[j].x && h[i].y < h[j].y) }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Point))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func escapeFire(fire [][]int, start []int, target []int) int {
	directions := []Point{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	m, n := len(fire), len(fire[0])
	fireTime := make([][]int, m)
	for i := range fireTime {
		fireTime[i] = make([]int, n)
		for j := range fireTime[i] {
			fireTime[i][j] = int(1e9)
		}
	}

	// BFS for fire spread
	fireQueue := []Point{}
	for _, f := range fire {
		fireQueue = append(fireQueue, Point{f[0], f[1]})
		fireTime[f[0]][f[1]] = 0
	}

	for len(fireQueue) > 0 {
		newFireQueue := []Point{}
		for _, p := range fireQueue {
			for _, d := range directions {
				nx, ny := p.x+d.x, p.y+d.y
				if nx >= 0 && nx < m && ny >= 0 && ny < n && fireTime[nx][ny] == int(1e9) {
					fireTime[nx][ny] = fireTime[p.x][p.y] + 1
					newFireQueue = append(newFireQueue, Point{nx, ny})
				}
			}
		}
		fireQueue = newFireQueue
	}

	// BFS for escape from the start point
	startPoint := Point{start[0], start[1]}
	targetPoint := Point{target[0], target[1]}
	escapeQueue := MinHeap{startPoint}
	heap.Init(&escapeQueue)
	escapeTime := 0

	for escapeQueue.Len() > 0 {
		p := heap.Pop(&escapeQueue).(Point)
		if p.x == targetPoint.x && p.y == targetPoint.y {
			return escapeTime
		}
		for _, d := range directions {
			nx, ny := p.x+d.x, p.y+d.y
			if nx >= 0 && nx < m && ny >= 0 && ny < n && escapeTime+1 < fireTime[nx][ny] {
				heap.Push(&escapeQueue, Point{nx, ny})
			}
		}
		escapeTime++
	}
	return -1
}

func main() {
	fire := [][]int{{1, 0}, {1, 1}, {1, 2}}
	start := []int{0, 0}
	target := []int{2, 2}
	fmt.Println(escapeFire(fire, start, target))
}