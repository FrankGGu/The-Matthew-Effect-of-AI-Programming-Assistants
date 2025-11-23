import "container/heap"

type Edge struct {
	U, V, W int
}

func modifiedGraphEdges(n int, edges [][]int, source int, destination int, target int) [][]int {
	adj := make([][]Edge, n)
	unknownEdges := [][]int{}

	for i, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		if w == -1 {
			unknownEdges = append(unknownEdges, []int{u, v, i})
			continue
		}
		adj[u] = append(adj[u], Edge{v, i, w})
		adj[v] = append(adj[v], Edge{u, i, w})
	}

	dist := func(weight int) int {
		for _, edge := range unknownEdges {
			u, v, i := edge[0], edge[1], edge[2]
			edges[i][2] = weight
			adj[u] = append(adj[u], Edge{v, i, weight})
			adj[v] = append(adj[v], Edge{u, i, weight})
		}

		d := make([]int, n)
		for i := range d {
			d[i] = 1 << 30
		}
		d[source] = 0

		pq := &PriorityQueue{}
		heap.Init(pq)
		heap.Push(pq, &Item{node: source, priority: 0})

		for pq.Len() > 0 {
			item := heap.Pop(pq).(*Item)
			u := item.node
			distU := item.priority

			if distU > d[u] {
				continue
			}

			for _, edge := range adj[u] {
				v, _, w := edge.U, edge.V, edge.W
				if d[v] > d[u]+w {
					d[v] = d[u] + w
					heap.Push(pq, &Item{node: v, priority: d[v]})
				}
			}
		}

		for _, edge := range unknownEdges {
			u, v, i := edge[0], edge[1], edge[2]
			adjU := []Edge{}
			for _, e := range adj[u] {
				if e.V != i {
					adjU = append(adjU, e)
				}
			}
			adj[u] = adjU
			adjV := []Edge{}
			for _, e := range adj[v] {
				if e.V != i {
					adjV = append(adjV, e)
				}
			}
			adj[v] = adjV
		}

		return d[destination]
	}

	l, r := 0, target+1
	ans := -1
	for l <= r {
		mid := l + (r-l)/2
		if dist(mid) <= target {
			ans = mid
			l = mid + 1
		} else {
			r = mid - 1
		}
	}

	if ans == -1 {
		return [][]int{}
	}

	dist(ans)

	if dist(ans) != target {
		return [][]int{}
	}

	for i, edge := range edges {
		if edge[2] == -1 {
			edges[i][2] = ans
		}
	}

	return edges
}

type Item struct {
	node     int
	priority int
	index    int
}

type PriorityQueue []*Item

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool {
	return pq[i].priority < pq[j].priority
}

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
	old[n-1] = nil  // avoid memory leak
	item.index = -1 // for safety
	*pq = old[0 : n-1]
	return item
}

func (pq *PriorityQueue) update(item *Item, node int, priority int) {
	item.node = node
	item.priority = priority
	heap.Fix(pq, item.index)
}