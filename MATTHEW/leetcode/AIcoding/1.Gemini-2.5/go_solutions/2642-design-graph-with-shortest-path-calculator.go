import (
	"math"
)

type Graph struct {
	n   int
	adj [][]int
}

func Constructor(n int, edges [][]int) Graph {
	g := Graph{
		n:   n,
		adj: make([][]int, n),
	}
	for i := range g.adj {
		g.adj[i] = make([]int, n)
		for j := range g.adj[i] {
			if i == j {
				g.adj[i][j] = 0
			} else {
				g.adj[i][j] = math.MaxInt32
			}
		}
	}

	for _, edge := range edges {
		g.AddEdge(edge)
	}
	return g
}

func (this *Graph) AddEdge(edge []int) {
	u, v, w := edge[0], edge[1], edge[2]
	if w < this.adj[u][v] {
		this.adj[u][v] = w
	}
}

func (this *Graph) ShortestPath(node1 int, node2 int) int {
	dist := make([]int, this.n)
	for i := range dist {
		dist[i] = math.MaxInt32
	}
	dist[node1] = 0

	visited := make([]bool, this.n)

	for count := 0; count < this.n; count++ {
		u := -1
		minDist := math.MaxInt32

		for i := 0; i < this.n; i++ {
			if !visited[i] && dist[i] < minDist {
				minDist = dist[i]
				u = i
			}
		}

		if u == -1 {
			break
		}

		visited[u] = true

		for v := 0; v < this.n; v++ {
			if this.adj[u][v] != math.MaxInt32 && dist[u] != math.MaxInt32 {
				if dist[u]+this.adj[u][v] < dist[v] {
					dist[v] = dist[u] + this.adj[u][v]
				}
			}
		}
	}

	if dist[node2] == math.MaxInt32 {
		return -1
	}
	return dist[node2]
}