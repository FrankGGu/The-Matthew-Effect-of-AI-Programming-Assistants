package main

import (
	"sort"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximizeTheNumberOfTargetNodes(n int, edges [][]int, target []int) int {
	// Handle edge case where there are no nodes.
	if n == 0 {
		return 0
	}

	// Build adjacency list.
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	// Convert target nodes list to a boolean array for O(1) lookup.
	isTarget := make([]bool, n)
	for _, node := range target {
		isTarget[node] = true
	}

	visited := make([]bool, n)

	// maxOverallDiameter tracks the maximum number of target nodes on any path
	// found so far, either within a single component or across connected components.
	maxOverallDiameter := 0

	// maxPathFromNodeInComponents stores the maximum number of target nodes on a path
	// starting from any node and extending downwards into its subtree, for each component.
	// These values are used to calculate the maximum path when connecting two components.
	maxPathFromNodeInComponents := []int{}

	// Iterate through all nodes to find and process each connected component.
	for i := 0; i < n; i++ {
		if !visited[i] {
			// For each new component, initialize the maximum path starting from a node within this component.
			currentMaxPathFromNodeInComponent := 0

			// innerDFS performs a Depth First Search to calculate path properties for the current component.
			// It returns the maximum number of target nodes on a path starting at 'u' and going down into its subtree.
			var innerDFS func(u, parent int) int
			innerDFS = func(u, parent int) int {
				visited[u] = true

				// path_down_u is the number of target nodes on a path starting at 'u'
				// and going down into its subtree, including 'u' itself if it's a target.
				path_down_u := 0
				if isTarget[u] {
					path_down_u = 1
				}

				// child_paths stores the max_path_down values returned by children.
				child_paths := []int{}
				for _, v := range adj[u] {
					if v == parent {
						continue
					}
					// Only recurse if the neighbor has not been visited yet (prevents infinite loops in trees).
					if !visited[v] {
						child_path_down_v := innerDFS(v, u)
						child_paths = append(child_paths, child_path_down_v)
					}
				}

				// Sort child_paths in descending order to easily get the two largest paths.
				sort.Slice(child_paths, func(i, j int) bool {
					return child_paths[i] > child_paths[j]
				})

				// current_max_path_down_u is the maximum path starting at 'u' and going down.
				// It's 'u' itself plus the longest path from one of its children.
				current_max_path_down_u := path_down_u
				if len(child_paths) > 0 {
					current_max_path_down_u += child_paths[0]
				}

				// Update the maximum path starting from any node within the current component.
				currentMaxPathFromNodeInComponent = max(currentMaxPathFromNodeInComponent, current_max_path_down_u)

				// current_diameter_through_u is the maximum path passing through 'u'.
				// It's 'u' itself plus the two longest paths from two of its children.
				current_diameter_through_u := path_down_u
				if len(child_paths) > 0 {
					current_diameter_through_u += child_paths[0]
				}
				if len(child_paths) > 1 {
					current_diameter_through_u += child_paths[1]
				}

				// Update the overall maximum diameter found so far across all components.
				maxOverallDiameter = max(maxOverallDiameter, current_diameter_through_u)

				return current_max_path_down_u
			}

			// Start DFS for the current component from node 'i'.
			innerDFS(i, -1)

			// After the DFS for this component completes, store its
			// currentMaxPathFromNodeInComponent value.
			maxPathFromNodeInComponents = append(maxPathFromNodeInComponents, currentMaxPathFromNodeInComponent)
		}
	}

	// Now, maxOverallDiameter holds the maximum diameter found within any single component.
	// We also need to consider connecting two components with one edge.
	// This involves taking the two components that have the largest 'maxPathFromNodeInComponent' values.

	// Sort maxPathFromNodeInComponents in descending order to easily get the two largest.
	sort.Slice(maxPathFromNodeInComponents, func(i, j int) bool {
		return maxPathFromNodeInComponents[i] > maxPathFromNodeInComponents[j]
	})

	// If there are at least two components, we can connect the two with the largest
	// 'maxPathFromNodeInComponent' values to potentially form a longer path.
	if len(maxPathFromNodeInComponents) >= 2 {
		// The sum of the two largest maxPathFromNodeInComponents values represents
		// the maximum path that can be formed by connecting these two components optimally.
		// Example: If C1 has a max path L1 starting at node u, and C2 has a max path L2 starting at node v.
		// Connecting u and v creates a path of length L1 + L2.
		maxOverallDiameter = max(maxOverallDiameter, maxPathFromNodeInComponents[0]+maxPathFromNodeInComponents[1])
	}

	return maxOverallDiameter
}