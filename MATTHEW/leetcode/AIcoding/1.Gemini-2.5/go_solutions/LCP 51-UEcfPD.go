package main

import (
	"container/list"
	"math"
)

const INF int64 = math.MaxInt64 / 2

type Edge struct {
	to       int
	capacity int
	cost     int64
	reverse  int
}

var graph [][]Edge
var dist []int64
var parentEdge []int
var parentNode []int
var inQueue []bool
var numNodes int

func addEdge(from, to, capacity int, cost int64) {
	graph[from] = append(graph[from], Edge{to, capacity, cost, len(graph[to])})
	graph[to] = append(graph[to], Edge{from, 0, -cost, len(graph[from]) - 1})
}

func spfa(s, t int) bool {
	for i := 0; i < numNodes; i++ {
		dist[i] = INF
		parentNode[i] = -1
		parentEdge[i] = -1
		inQueue[i] = false
	}

	queue := list.New()

	dist[s] = 0
	queue.PushBack(s)
	inQueue[s] = true

	for queue.Len() > 0 {
		u := queue.Remove(queue.Front()).(int)
		inQueue[u] = false

		for i := 0; i < len(graph[u]); i++ {
			edge := &graph[u][i]
			if edge.capacity > 0 && dist[edge.to] > dist[u]+edge.cost {
				dist[edge.to] = dist[u] + edge.cost
				parentNode[edge.to] = u
				parentEdge[edge.to] = i
				if !inQueue[edge.to] {
					queue.PushBack(edge.to)
					inQueue[edge.to] = true
				}
			}
		}
	}

	return dist[t] != INF
}

func minCostMaxFlow(s, t int, maxPossibleFlow int) (int, int64) {
	totalFlow := 0
	totalCost := int64(0)

	dist = make([]int64, numNodes)
	parentEdge = make([]int, numNodes)
	parentNode = make([]int, numNodes)
	inQueue = make([]bool, numNodes)

	for totalFlow < maxPossibleFlow && spfa(s, t) {
		pathFlow := 1 // Each augmenting path corresponds to cooking one dish

		totalFlow += pathFlow
		totalCost += dist[t] * int64(pathFlow)

		curr := t
		for curr != s {
			edge := &graph[parentNode[curr]][parentEdge[curr]]
			edge.capacity -= pathFlow
			graph[edge.to][edge.reverse].capacity += pathFlow
			curr = parentNode[curr]
		}
	}

	return totalFlow, totalCost
}

func cooking(n int, materials []int, cookbooks [][]int) []int {
	numCookbooks := len(cookbooks)
	numNodes = n + numCookbooks + 2
	s := 0
	t := numNodes - 1

	graph = make([][]Edge, numNodes)

	for i := 0; i < n; i++ {
		addEdge(s, i+1, materials[i], 0)
	}

	for j := 0; j < numCookbooks; j++ {
		price := cookbooks[j][n]
		addEdge(n+1+j, t, 1, int64(-price))
	}

	for i := 0; i < n; i++ {
		for j := 0; j < numCookbooks; j++ {
			required := cookbooks[j][i]
			if required > 0 {
				addEdge(i+1, n+1+j, required, 0)
			}
		}
	}

	maxPossibleFlow := numCookbooks

	flow, cost := minCostMaxFlow(s, t, maxPossibleFlow)

	return []int{flow, int(-cost)}
}