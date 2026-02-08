package main

type SegmentTree struct {
	tree []int
	arr  []int
	n    int
}

func build(tree, arr []int, node, start, end int) {
	if start == end {
		tree[node] = arr[start]
	} else {
		mid := (start + end) / 2
		build(tree, arr, 2*node, start, mid)
		build(tree, arr, 2*node+1, mid+1, end)
		tree[node] = tree[2*node] + tree[2*node+1]
	}
}

func update(tree []int, node, start, end, idx, val int) {
	if start == end {
		tree[node] = val
	} else {
		mid := (start + end) / 2
		if start <= idx && idx <= mid {
			update(tree, 2*node, start, mid, idx, val)
		} else {
			update(tree, 2*node+1, mid+1, end, idx, val)
		}
		tree[node] = tree[2*node] + tree[2*node+1]
	}
}

func query(tree []int, node, start, end, l, r int) int {
	if r < start || end < l {
		return 0
	}
	if l <= start && end <= r {
		return tree[node]
	}
	mid := (start + end) / 2
	p1 := query(tree, 2*node, start, mid, l, r)
	p2 := query(tree, 2*node+1, mid+1, end, l, r)
	return p1 + p2
}

var (
	adj         [][]int
	parent      []int
	depth       []int
	subtreeSize []int
	heavyChild  []int
	head        []int
	pos         []int
	nodeAtPos   []int
	timer       int
)

func dfs1(u, p, d int) {
	parent[u] = p
	depth[u] = d
	subtreeSize[u] = 1
	maxChildSize := 0
	for _, v := range adj[u] {
		if v == p {
			continue
		}
		dfs1(v, u, d+1)
		subtreeSize[u] += subtreeSize[v]
		if subtreeSize[v] > maxChildSize {
			maxChildSize = subtreeSize[v]
			heavyChild[u] = v
		}
	}
}

func dfs2(u, h int) {
	head[u] = h
	pos[u] = timer
	nodeAtPos[timer] = u
	timer++

	if heavyChild[u] != -1 {
		dfs2(heavyChild[u], h)
	}

	for _, v := range adj[u] {
		if v == parent[u] || v == heavyChild[u] {
			continue
		}
		dfs2(v, v)
	}
}

func findSubtreeSizesAfterChanges(n int, edges [][]int, queries [][]int) []int {
	adj = make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	parent = make([]int, n)
	depth = make([]int, n)
	subtreeSize = make([]int, n)
	heavyChild = make([]int, n)
	for i := 0; i < n; i++ {
		heavyChild[i] = -1
	}

	head = make([]int, n)
	pos = make([]int, n)
	nodeAtPos = make([]int, n)
	timer = 0

	dfs1(0, -1, 0)
	dfs2(0, 0)

	initialArr := make([]int, n)
	for i := 0; i < n; i++ {
		initialArr[pos[i]] = 1
	}

	segTree := make([]int, 4*n)
	build(segTree, initialArr, 1, 0, n-1)

	var results []int

	for _, q := range queries {
		nodeID := q[0]
		queryType := q[1]

		if queryType == 0 {
			update(segTree, 1, 0, n-1, pos[nodeID], 0)
		} else if queryType == 1 {
			update(segTree, 1, 0, n-1, pos[nodeID], 1)
		} else {
			res := query(segTree, 1, 0, n-1, pos[nodeID], pos[nodeID]+subtreeSize[nodeID]-1)
			results = append(results, res)
		}
	}

	return results
}