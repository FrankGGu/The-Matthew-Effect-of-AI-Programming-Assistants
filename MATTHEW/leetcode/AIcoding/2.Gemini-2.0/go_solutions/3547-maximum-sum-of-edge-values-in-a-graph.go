import (
	"container/heap"
)

type Edge struct {
	U, V, W int
}

type MaxHeap []Edge

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i].W > h[j].W }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(Edge))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxEdgeValue(edges [][]int, k int) int {
	n := len(edges)
	h := &MaxHeap{}
	heap.Init(h)

	for i := 0; i < n; i++ {
		heap.Push(h, Edge{edges[i][0], edges[i][1], edges[i][2]})
	}

	adj := make(map[int][]int)
	weights := make(map[int]int)
	parent := make([]int, 10001)
	for i := 0; i < 10001; i++ {
		parent[i] = i
	}

	var find func(int) int
	find = func(x int) int {
		if parent[x] == x {
			return x
		}
		parent[x] = find(parent[x])
		return parent[x]
	}

	union := func(x, y int, w int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			parent[rootX] = rootY
			adj[x] = append(adj[x], y)
			adj[y] = append(adj[y], x)
			weights[x*10001+y] = w
			weights[y*10001+x] = w
		}
	}

	count := 0
	for h.Len() > 0 && count < 10001-1 {
		edge := heap.Pop(h).(Edge)
		if find(edge.U) != find(edge.V) {
			union(edge.U, edge.V, edge.W)
			count++
		}
	}

	visited := make([]bool, 10001)
	ans := 0
	var dfs func(int, int, int)
	dfs = func(node, parent, currentSum int) {
		visited[node] = true
		ans = max(ans, currentSum)

		for neighbor := 0; neighbor < 10001; neighbor++ {
			if weights[node*10001+neighbor] > 0 && neighbor != parent {
				dfs(neighbor, node, currentSum+weights[node*10001+neighbor])
			}
		}
	}

	for i := 0; i < 10001; i++ {
		visited[i] = false
	}

	for i := 0; i < 10001; i++ {
		if len(adj[i]) > 0 && !visited[i] {
			dfs(i, -1, 0)
		}
	}

	return ans % (int(1e9) + 7)
}