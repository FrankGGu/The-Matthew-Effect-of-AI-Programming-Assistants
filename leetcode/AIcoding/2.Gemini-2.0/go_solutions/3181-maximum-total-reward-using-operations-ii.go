import "fmt"

func maximumTotalReward(rewards []int, ops [][]int) int {
	n := len(rewards)
	parent := make([]int, n)
	for i := range parent {
		parent[i] = i
	}

	var find func(int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			parent[rootX] = rootY
		}
	}

	adj := make([][]int, n)
	for _, op := range ops {
		adj[op[0]] = append(adj[op[0]], op[1])
		adj[op[1]] = append(adj[1], op[0])
	}

	type Edge struct {
		U, V int
	}

	edges := make([]Edge, 0)
	for u := 0; u < n; u++ {
		for _, v := range adj[u] {
			if u < v {
				edges = append(edges, Edge{u, v})
			}
		}
	}

	mstCost := 0
	mstEdges := 0
	for _, edge := range edges {
		u, v := edge.U, edge.V
		if find(u) != find(v) {
			union(u, v)
			mstCost += min(rewards[u], rewards[v])
			mstEdges++
		}
	}

	sumRewards := 0
	for _, reward := range rewards {
		sumRewards += reward
	}

	return sumRewards - mstCost
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}