package main

import (
	"container/heap"
)

type Edge struct {
	to, weight int
}

type Graph struct {
	nodes map[int][]Edge
}

func NewGraph() *Graph {
	return &Graph{
		nodes: make(map[int][]Edge),
	}
}

func (g *Graph) AddEdge(u, v, w int) {
	g.nodes[u] = append(g.nodes[u], Edge{v, w})
	g.nodes[v] = append(g.nodes[v], Edge{u, w})
}

type PriorityQueue []*Node

type Node struct {
	node, dist int
}

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].dist < pq[j].dist
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	*pq = append(*pq, x.(*Node))
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	x := old[n-1]
	*pq = old[0 : n-1]
	return x
}

func dijkstra(graph *Graph, start int) map[int]int {
	dist := make(map[int]int)
	for node := range graph.nodes {
		dist[node] = int(^uint(0) >> 1)
	}
	dist[start] = 0
	pq := make(PriorityQueue, 0)
	heap.Push(&pq, &Node{start, 0})

	for pq.Len() > 0 {
		curr := heap.Pop(&pq).(*Node)
		if curr.dist > dist[curr.node] {
			continue
		}
		for _, edge := range graph.nodes[curr.node] {
			newDist := curr.dist + edge.weight
			if newDist < dist[edge.to] {
				dist[edge.to] = newDist
				heap.Push(&pq, &Node{edge.to, newDist})
			}
		}
	}
	return dist
}

func minWeightedSubgraphWithRequiredPaths(n int, edges [][]int, src1 int, src2 int, dest int) int {
	graph := NewGraph()
	for _, e := range edges {
		graph.AddEdge(e[0], e[1], e[2])
	}

	distFromSrc1 := dijkstra(graph, src1)
	distFromSrc2 := dijkstra(graph, src2)
	distFromDest := dijkstra(graph, dest)

	minTotal := int(^uint(0) >> 1)

	for node := range graph.nodes {
		total := distFromSrc1[node] + distFromSrc2[node] + distFromDest[node]
		if total < minTotal {
			minTotal = total
		}
	}

	if minTotal == int(^uint(0)>>1) {
		return -1
	}
	return minTotal
}