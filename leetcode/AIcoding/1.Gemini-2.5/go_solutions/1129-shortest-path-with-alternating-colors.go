import "math"

func shortestAlternatingPaths(n int, redEdges [][]int, blueEdges [][]int) []int {
	// adj[node][color] stores list of neighbors
	// 0 for red, 1 for blue
	adj := make([][][]int, n)
	for i := 0; i < n; i++ {
		adj[i] = make([][]int, 2)
	}

	for _, edge := range redEdges {
		from, to := edge[0], edge[1]
		adj[from][0] = append(adj[from][0], to)
	}

	for _, edge := range blueEdges {
		from, to := edge[0], edge[1]
		adj[from][1] = append(adj[from][1], to)
	}

	// dist[node][last_color] stores the shortest path length to 'node'
	// where the last edge taken to reach 'node' was 'last_color'.
	// Initialize with a large value (infinity).
	dist := make([][]int, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int, 2)
		dist[i][0] = math.MaxInt32
		dist[i][1] = math.MaxInt32
	}

	// BFS queue: stores {node, last_color}
	type state struct {
		node      int
		lastColor int // 0 for red, 1 for blue
	}
	q := []state{}

	// Start node 0 has distance 0.
	// We add two initial states to the queue, representing paths to node 0
	// conceptually ending with a red or blue edge. This allows the BFS
	// to explore paths starting with either color from node 0.
	dist[0][0] = 0
	dist[0][1] = 0
	q = append(q, state{node: 0, lastColor: 0}) // Path to 0 ending with red
	q = append(q, state{node: 0, lastColor: 1}) // Path to 0 ending with blue

	head := 0
	for head < len(q) {
		curr := q[head]
		head++

		u := curr.node
		lastColor := curr.lastColor
		d := dist[u][lastColor]

		// Explore neighbors using the *opposite* color edge
		nextColor := 1 - lastColor
		for _, v := range adj[u][nextColor] {
			if dist[v][nextColor] == math.MaxInt32 { // If not visited yet with this incoming color
				dist[v][nextColor] = d + 1
				q = append(q, state{node: v, lastColor: nextColor})
			}
		}
	}

	// Construct the final answer array
	ans := make([]int, n)
	for i := 0; i < n; i++ {
		minDist := math.MaxInt32
		if dist[i][0] < minDist {
			minDist = dist[i][0]
		}
		if dist[i][1] < minDist {
			minDist = dist[i][1]
		}

		if minDist == math.MaxInt32 {
			ans[i] = -1 // Unreachable
		} else {
			ans[i] = minDist
		}
	}

	return ans
}