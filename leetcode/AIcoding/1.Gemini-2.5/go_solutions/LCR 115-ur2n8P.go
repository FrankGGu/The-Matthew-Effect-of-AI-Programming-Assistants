func sequenceReconstruction(org []int, seqs [][]int) bool {
	n := len(org)
	if n == 0 {
		return true
	}

	// nodePresentInSeqs tracks which numbers from org are actually present in any of the sequences.
	// All numbers in org must be present in seqs to be reconstructible.
	nodePresentInSeqs := make(map[int]bool)
	for _, seq := range seqs {
		for _, val := range seq {
			// Only consider values within org's range [1, n]
			if val >= 1 && val <= n {
				nodePresentInSeqs[val] = true
			}
		}
	}

	// If not all elements of org are present in any sequence, org cannot be reconstructed.
	if len(nodePresentInSeqs) < n {
		return false
	}

	// Adjacency list for graph
	adj := make(map[int][]int)
	// In-degree for each node
	inDegree := make(map[int]int)

	// Initialize in-degrees for all numbers from 1 to n (numbers in org)
	for i := 1; i <= n; i++ {
		inDegree[i] = 0
	}

	// Build the graph
	for _, seq := range seqs {
		for i := 0; i < len(seq); i++ {
			curr := seq[i]
			// Skip numbers outside the valid range [1, n]
			if curr < 1 || curr > n {
				continue
			}

			if i > 0 {
				prev := seq[i-1]
				// Skip if previous number is also outside the valid range
				if prev < 1 || prev > n {
					continue
				}
				// Add edge prev -> curr
				adj[prev] = append(adj[prev], curr)
				inDegree[curr]++
			}
		}
	}

	// Topological sort
	queue := []int{}
	for i := 1; i <= n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	result := []int{}
	for len(queue) > 0 {
		// Uniqueness check: If more than one node has an in-degree of 0,
		// it means there are multiple choices for the next element,
		// so the sequence is not uniquely reconstructible.
		if len(queue) > 1 {
			return false
		}

		u := queue[0]
		queue = queue[1:]
		result = append(result, u)

		for _, v := range adj[u] {
			inDegree[v]--
			if inDegree[v] == 0 {
				queue = append(queue, v)
			}
		}
	}

	// Final checks:
	// 1. The length of the reconstructed sequence must be equal to n.
	//    If not, it means some elements of org were not processed (e.g., due to a cycle, or not being reachable).
	if len(result) != n {
		return false
	}

	// 2. The reconstructed sequence must be exactly `org`.
	for i := 0; i < n; i++ {
		if result[i] != org[i] {
			return false
		}
	}

	return true
}