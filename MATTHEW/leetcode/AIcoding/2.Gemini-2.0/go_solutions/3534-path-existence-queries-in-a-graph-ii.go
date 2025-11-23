import (
	"container/heap"
)

type Edge struct {
	to     int
	weight int
}

type Node struct {
	node   int
	dist   int
}

type PriorityQueue []Node

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].dist < pq[j].dist
}

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
}

func (pq *PriorityQueue) Push(x interface{}) {
	item := x.(Node)
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

type Graph struct {
	adjList map[int][]Edge
}

func NewGraph(n int, edges [][]int) *Graph {
	g := &Graph{adjList: make(map[int][]Edge)}
	for i := 0; i < n; i++ {
		g.adjList[i] = []Edge{}
	}
	for _, edge := range edges {
		g.addEdge(edge[0], edge[1], edge[2])
	}
	return g
}

func (g *Graph) addEdge(from, to, weight int) {
	g.adjList[from] = append(g.adjList[from], Edge{to: to, weight: weight})
}

func (g *Graph) ShortestPath(node1, node2 int) int {
	n := len(g.adjList)
	dist := make([]int, n)
	for i := 0; i < n; i++ {
		dist[i] = 1e9 + 7
	}
	dist[node1] = 0

	pq := &PriorityQueue{}
	heap.Init(pq)
	heap.Push(pq, Node{node: node1, dist: 0})

	for pq.Len() > 0 {
		curr := heap.Pop(pq).(Node)
		u := curr.node
		d := curr.dist

		if d > dist[u] {
			continue
		}

		for _, edge := range g.adjList[u] {
			v := edge.to
			weight := edge.weight

			if dist[v] > dist[u]+weight {
				dist[v] = dist[u] + weight
				heap.Push(pq, Node{node: v, dist: dist[v]})
			}
		}
	}

	if dist[node2] == 1e9+7 {
		return -1
	}
	return dist[node2]
}