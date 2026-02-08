package main

import (
	"container/heap"
	"fmt"
)

type Edge struct {
	to   int
	cost int
}

type Graph [][]Edge

type Item struct {
	node int
	cost int
	index int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].cost < pq[j].cost }
func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	item := x.(*Item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func findEdges(n int, edges [][]int, start int, end int) [][]int {
	graph := make(Graph, n+1)
	for _, e := range edges {
		graph[e[0]] = append(graph[e[0]], Edge{to: e[1], cost: e[2]})
		graph[e[1]] = append(graph[e[1]], Edge{to: e[0], cost: e[2]})
	}

	dist := make([]int, n+1)
	for i := range dist {
		dist[i] = int(1e9)
	}
	dist[start] = 0

	pq := &PriorityQueue{}
	heap.Push(pq, &Item{node: start, cost: 0})

	parents := make([][]int, n+1)
	for i := range parents {
		parents[i] = []int{}
	}

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(*Item)
		node := curr.node

		for _, edge := range graph[node] {
			newDist := dist[node] + edge.cost
			if newDist < dist[edge.to] {
				dist[edge.to] = newDist
				parents[edge.to] = []int{node}
				heap.Push(pq, &Item{node: edge.to, cost: newDist})
			} else if newDist == dist[edge.to] {
				parents[edge.to] = append(parents[edge.to], node)
			}
		}
	}

	edgesInPath := [][]int{}
	var dfs func(node, target int)
	dfs = func(node, target int) {
		if node == target {
			return
		}
		for _, parent := range parents[node] {
			edgesInPath = append(edgesInPath, []int{parent, node})
			dfs(parent, target)
		}
	}

	dfs(end, start)
	return edgesInPath
}

func main() {
	n := 5
	edges := [][]int{
		{1, 2, 1},
		{1, 3, 2},
		{2, 3, 1},
		{2, 4, 4},
		{3, 4, 1},
		{4, 5, 1},
	}
	start := 1
	end := 5
	result := findEdges(n, edges, start, end)
	fmt.Println(result)
}