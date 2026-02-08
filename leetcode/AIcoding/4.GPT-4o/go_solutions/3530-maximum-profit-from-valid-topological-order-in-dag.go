package main

import (
	"container/heap"
	"fmt"
)

type Edge struct {
	to     int
	profit int
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func maxProfit(n int, edges [][]int, profits []int) int {
	graph := make([][]Edge, n)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], Edge{to: edge[1], profit: profits[edge[1]]})
	}

	inDegree := make([]int, n)
	for _, edge := range edges {
		inDegree[edge[1]]++
	}

	maxHeap := &MaxHeap{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			heap.Push(maxHeap, profits[i])
		}
	}

	totalProfit := 0
	for maxHeap.Len() > 0 {
		currentProfit := heap.Pop(maxHeap).(int)
		totalProfit += currentProfit

		for _, edge := range graph[totalProfit] {
			inDegree[edge.to]--
			if inDegree[edge.to] == 0 {
				heap.Push(maxHeap, edge.profit)
			}
		}
	}

	return totalProfit
}

func main() {
	n := 5
	edges := [][]int{{0, 1}, {0, 2}, {1, 3}, {2, 3}, {3, 4}}
	profits := []int{5, 1, 2, 10, 2}
	fmt.Println(maxProfit(n, edges, profits))
}