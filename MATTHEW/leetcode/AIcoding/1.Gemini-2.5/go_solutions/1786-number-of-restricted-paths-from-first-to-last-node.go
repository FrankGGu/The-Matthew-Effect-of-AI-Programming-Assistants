package main

import (
	"container/heap"
	"math"
)

type IntHeap [][2]int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.([2]int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

const MOD = 1_000_000_007

func countRestrictedPaths(n int, edges [][]int) int {
	adj := make([][][2]int, n+1)
	for _, edge := range edges {
		u, v, w := edge[0], edge[1], edge[2]
		adj[u] = append(adj[u], [2]int{v, w})
		adj[v] = append(adj[v], [2]int{u, w})
	}

	dist := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dist[i] = math.MaxInt32
	}
	dist[n] = 0

	pq := &IntHeap{}
	heap.Init(pq)
	heap.Push(pq, [2]int{0, n})

	for pq.Len() > 0 {
		curr := heap.Pop(pq).([2]int)
		d, u := curr[0], curr[1]

		if d > dist[u] {
			continue
		}

		for _, edge := range adj[u] {
			v, weight := edge[0], edge[1]
			if dist[u]+weight < dist[v] {
				dist[v] = dist[u] + weight
				heap.Push(pq, [2]int{dist[v], v})
			}
		}
	}

	memo := make([]int, n+1)

	var dfs func(u int) int
	dfs = func(u int) int {
		if u == n {
			return 1
		}
		if memo[u] != 0 {
			return memo[u]
		}

		count := 0
		for _, edge := range adj[u] {
			v := edge[0]
			if dist[u] > dist[v] {
				count = (count + dfs(v)) % MOD
			}
		}
		memo[u] = count
		return count
	}

	return dfs(1)
}