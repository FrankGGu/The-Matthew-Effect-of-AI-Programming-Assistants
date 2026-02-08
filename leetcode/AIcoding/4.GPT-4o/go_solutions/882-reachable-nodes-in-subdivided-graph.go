package main

import (
	"container/heap"
	"fmt"
)

type Edge struct {
	to, count int
}

type Item struct {
	node, reachable int
}

type MinHeap []Item

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i].reachable < h[j].reachable }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func reachableNodes(edges [][]int, maxMoves int, n int) int {
	graph := make(map[int][]Edge)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], Edge{edge[1], edge[2]})
		graph[edge[1]] = append(graph[edge[1]], Edge{edge[0], edge[2]})
	}

	visited := make([]bool, n)
	h := &MinHeap{}
	heap.Push(h, Item{0, maxMoves})

	count := 0
	for h.Len() > 0 {
		item := heap.Pop(h).(Item)
		node, reachable := item.node, item.reachable
		if visited[node] {
			continue
		}
		visited[node] = true
		count++

		for _, edge := range graph[node] {
			if !visited[edge.to] {
				move := reachable - edge.count - 1
				if move >= 0 {
					heap.Push(h, Item{edge.to, move})
				}
			}
		}
	}
	return count
}

func main() {
	edges := [][]int{{0, 1, 10}, {0, 2, 1}, {1, 2, 2}}
	maxMoves := 6
	n := 3
	result := reachableNodes(edges, maxMoves, n)
	fmt.Println(result)
}