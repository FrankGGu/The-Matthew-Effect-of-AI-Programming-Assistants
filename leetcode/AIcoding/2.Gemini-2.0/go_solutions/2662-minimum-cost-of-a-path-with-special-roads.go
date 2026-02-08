import (
	"container/heap"
	"math"
)

type Edge struct {
	to   int
	cost int
}

type Node struct {
	id    int
	dist  int
	index int
}

type PriorityQueue []*Node

func (pq PriorityQueue) Len() int {
	return len(pq)
}

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].dist < pq[j].dist
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	node := x.(*Node)
	node.index = n
	*pq = append(*pq, node)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	node := old[n-1]
	old[n-1] = nil  // avoid memory leak
	node.index = -1 // for safety
	*pq = old[0 : n-1]
	return node
}

func minCostConnectPoints(points [][]int, specialRoads [][]int) int {
	n := len(points)

	adj := make([][]Edge, n+2)

	for i := 0; i < n; i++ {
		adj[n].to = i
		adj[n].cost = abs(points[i][0]-points[0][0]) + abs(points[i][1]-points[0][1])
		adj[i] = make([]Edge, 0)
	}

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i != j {
				adj[i] = append(adj[i], Edge{to: j, cost: abs(points[i][0]-points[j][0]) + abs(points[i][1]-points[j][1])})
			}
		}
	}

	for _, road := range specialRoads {
		x1, y1, x2, y2, cost := road[0], road[1], road[2], road[3], road[4]
		u, v := -1, -1
		for i := 0; i < n; i++ {
			if points[i][0] == x1 && points[i][1] == y1 {
				u = i
			}
			if points[i][0] == x2 && points[i][1] == y2 {
				v = i
			}
		}
		if u != -1 && v != -1 {
			adj[u] = append(adj[u], Edge{to: v, cost: cost})
		} else if u == -1 && v != -1 {
			adj[n] = append(adj[n], Edge{to: v, cost: abs(x1-points[0][0]) + abs(y1-points[0][1]) + cost})
		} else if u != -1 && v == -1 {
			adj[u] = append(adj[u], Edge{to: n + 1, cost: cost + abs(x2 - points[0][0]) + abs(y2 - points[0][1])})
		} else {
			adj[n] = append(adj[n], Edge{to: n + 1, cost: abs(x1 - points[0][0]) + abs(y1 - points[0][1]) + cost + abs(x2 - points[0][0]) + abs(y2 - points[0][1])})
		}
	}

	dist := make([]int, n+2)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[n] = 0

	pq := make(PriorityQueue, 0)
	heap.Init(&pq)
	heap.Push(&pq, &Node{id: n, dist: 0})

	for pq.Len() > 0 {
		u := heap.Pop(&pq).(*Node)

		if u.dist > dist[u.id] {
			continue
		}

		for _, edge := range adj[u.id] {
			if dist[edge.to] > dist[u.id]+edge.cost {
				dist[edge.to] = dist[u.id] + edge.cost
				heap.Push(&pq, &Node{id: edge.to, dist: dist[edge.to]})
			}
		}
	}

	minDist := math.MaxInt32
	for i := 0; i < n; i++ {
		if abs(points[i][0]-points[len(points)-1][0])+abs(points[i][1]-points[len(points)-1][1]) < minDist {
			minDist = abs(points[i][0]-points[len(points)-1][0]) + abs(points[i][1]-points[len(points)-1][1])
		}
	}
	result := math.MaxInt32
	for i := 0; i < n; i++ {
		result = min(result, dist[i]+abs(points[i][0]-points[len(points)-1][0])+abs(points[i][1]-points[len(points)-1][1]))
	}
	result = min(result, dist[n+1])

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minimumCost(start []int, target []int, specialRoads [][]int) int {
	x1, y1 := start[0], start[1]
	x2, y2 := target[0], target[1]
	n := len(specialRoads)
	points := make([][]int, 0)
	points = append(points, []int{x1, y1})

	for i := 0; i < n; i++ {
		points = append(points, []int{specialRoads[i][0], specialRoads[i][1]})
	}
	points = append(points, []int{x2, y2})

	return minCostConnectPoints(points, specialRoads)
}