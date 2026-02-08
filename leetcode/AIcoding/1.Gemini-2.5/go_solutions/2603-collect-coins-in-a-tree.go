func collectTheCoins(coins []int, edges [][]int) int {
	n := len(coins)
	if n <= 1 {
		return 0
	}

	adj := make([][]int, n)
	degree := make([]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
		degree[u]++
		degree[v]++
	}

	is_active := make([]bool, n)
	for i := range is_active {
		is_active[i] = true
	}

	// --- Round 1 Pruning: Remove branches without any coins ---
	// Initialize queue with all leaf nodes that do not have coins.
	q := []int{}
	for i := 0; i < n; i++ {
		// A node is a leaf if its degree is 1.
		// We only prune if it doesn't have a coin.
		// Node 0 is special, it's the starting point and guaranteed to have a coin.
		// However, if coins[0] is 0, it would be pruned, which is fine if it's not needed.
		// The problem states coins[0] is guaranteed to be 1, so node 0 won't be pruned here unless it's the only node.
		if degree[i] == 1 && coins[i] == 0 {
			q = append(q, i)
		}
	}

	// Perform BFS to prune nodes
	for len(q) > 0 {
		u := q[0]
		q = q[1:]

		if !is_active[u] { // Already processed
			continue
		}

		is_active[u] = false // Mark node u as inactive (pruned)

		for _, v := range adj[u] {
			if is_active[v] { // Only process active neighbors
				degree[v]-- // Decrement degree of neighbor v in the active graph
				// If v becomes a leaf, has no coin, and is not node 0, add it to queue for pruning
				if degree[v] == 1 && coins[v] == 0 && v != 0 {
					q = append(q, v)
				}
			}
		}
	}

	// After Round 1, `is_active` marks nodes in the "coin-relevant" tree.
	// `degree` array now reflects degrees in this "coin-relevant" tree.

	// --- Round 2 Pruning (2 layers): Remove outermost two layers of edges ---
	// This step removes nodes that are "too far" from any coin node, specifically
	// those that are 1 or 2 steps away from a leaf in the coin-relevant tree.
	q = []int{}
	for i := 0; i < n; i++ {
		// Add active leaves that are not node 0 to the queue for this pruning round.
		// Node 0 must never be pruned.
		if is_active[i] && degree[i] == 1 && i != 0 {
			q = append(q, i)
		}
	}

	// Perform two iterations of removing leaves
	for k := 0; k < 2; k++ {
		size := len(q)
		if size == 0 { // No more leaves to prune in this or subsequent rounds
			break
		}

		for i := 0; i < size; i++ {
			u := q[0]
			q = q[1:]

			if !is_active[u] { // Already processed in this round or a previous round
				continue
			}

			is_active[u] = false // Mark node u as inactive

			for _, v := range adj[u] {
				if is_active[v] { // Only process active neighbors
					degree[v]-- // Decrement degree of neighbor v
					// If v becomes a leaf in the active tree (and not node 0), add to queue
					if degree[v] == 1 && v != 0 {
						q = append(q, v)
					}
				}
			}
		}
	}

	// Count remaining edges in the final active tree
	// Each edge in this final tree must be traversed twice (to and from)
	remainingEdges := 0
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		if is_active[u] && is_active[v] {
			remainingEdges++
		}
	}

	return 2 * remainingEdges
}