package main

import (
	"math"
)

const INF = math.MaxInt32 / 2 // A sufficiently large value for infinity

func numberOfPossibleSets(n int, roads [][]int, maxDistance int) int {
	count := 0

	// Iterate through all non-empty subsets of branches using a bitmask
	// `i` represents a subset: if the k-th bit is set, branch k is included.
	for i := 1; i < (1 << n); i++ {
		// Extract the 0-indexed branches included in the current subset
		selectedBranches := []int{}
		for k := 0; k < n; k++ {
			if (i>>k)&1 == 1 {
				selectedBranches = append(selectedBranches, k)
			}
		}

		numSelected := len(selectedBranches)
		if numSelected == 0 {
			continue // Should not happen with `i` starting from 1
		}
		if numSelected == 1 {
			count++ // A single branch always forms a valid set (max distance is 0)
			continue
		}

		// Map original branch indices to their indices within the `selectedBranches` slice
		originalToSubsetIdx := make(map[int]int)
		for idx, originalBranch := range selectedBranches {
			originalToSubsetIdx[originalBranch] = idx
		}

		// Initialize an adjacency matrix for the current subset
		// dist[u_idx][v_idx] will store the shortest path between the u_idx-th and v_idx-th selected branch.
		dist := make([][]int, numSelected)
		for r := 0; r < numSelected; r++ {
			dist[r] = make([]int, numSelected)
			for c := 0; c < numSelected; c++ {
				if r == c {
					dist[r][c] = 0 // Distance to self is 0
				} else {
					dist[r][c] = INF // Initialize with infinity for disconnected pairs
				}
			}
		}

		// Populate the adjacency matrix with direct road lengths for branches within the subset
		for _, road := range roads {
			u, v, l := road[0], road[1], road[2]

			// Check if both branches of the road are in the current subset
			_, uInSubset := originalToSubsetIdx[u]
			_, vInSubset := originalToSubsetIdx[v]

			if uInSubset && vInSubset {
				u_idx := originalToSubsetIdx[u]
				v_idx := originalToSubsetIdx[v]
				// Update with the minimum length if multiple roads exist or a shorter path is found
				dist[u_idx][v_idx] = min(dist[u_idx][v_idx], l)
				dist[v_idx][u_idx] = min(dist[v_idx][u_idx], l) // Roads are bidirectional
			}
		}

		// Apply Floyd-Warshall algorithm to find all-pairs shortest paths within the subset
		for k := 0; k < numSelected; k++ { // Intermediate node
			for r := 0; r < numSelected; r++ { // Source node
				for c := 0; c < numSelected; c++ { // Destination node
					if dist[r][k] != INF && dist[k][c] != INF { // Check for reachability
						dist[r][c] = min(dist[r][c], dist[r][k]+dist[k][c])
					}
				}
			}
		}

		// Check if the current subset forms a valid set
		isValidSet := true
		currentMaxDist := 0
		for r := 0; r < numSelected; r++ {
			for c := 0; c < numSelected; c++ {
				if dist[r][c] == INF {
					// If any pair of branches is not connected, the set is invalid
					isValidSet = false
					break
				}
				// Keep track of the maximum distance found between any two branches
				currentMaxDist = max(currentMaxDist, dist[r][c])
			}
			if !isValidSet {
				break
			}
		}

		// If the set is valid and its maximum distance is within the allowed limit, increment the count
		if isValidSet && currentMaxDist <= maxDistance {
			count++
		}
	}

	return count
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}