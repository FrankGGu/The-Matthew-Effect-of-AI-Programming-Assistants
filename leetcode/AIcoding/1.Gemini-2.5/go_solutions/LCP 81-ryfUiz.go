package main

import "fmt"

var (
	adj       [][]int
	dfn       []int
	low       []int
	sccID     []int
	timer     int
	sccCount  int
	stack     []int
	inStack   []bool
	numNodes  int // Total number of nodes in the implication graph (2*n)
)

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func tarjanDFS(u int) {
	timer++
	dfn[u] = timer
	low[u] = timer
	stack = append(stack, u)
	inStack[u] = true

	for _, v := range adj[u] {
		if dfn[v] == 0 { // If v has not been visited
			tarjanDFS(v)
			low[u] = min(low[u], low[v])
		} else if inStack[v] { // If v is in the current DFS stack (back edge)
			low[u] = min(low[u], dfn[v])
		}
	}

	if low[u] == dfn[u] { // u is the root of an SCC
		sccCount++
		for {
			node := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			inStack[node] = false
			sccID[node] = sccCount // Assign current SCC ID
			if node == u {
				break
			}
		}
	}
}

func solve(n int, m int, ops [][]int) bool {
	// Initialize global variables for Tarjan's algorithm for each test case
	// There are 2*n nodes in the implication graph:
	// Nodes 0 to n-1 represent x_0 to x_{n-1} (positive literals)
	// Nodes n to 2*n-1 represent NOT x_0 to NOT x_{n-1} (negative literals)
	numNodes = 2 * n

	adj = make([][]int, numNodes)
	dfn = make([]int, numNodes)
	low = make([]int, numNodes)
	sccID = make([]int, numNodes)
	timer = 0
	sccCount = 0
	stack = make([]int, 0, numNodes) // Pre-allocate capacity for stack
	inStack = make([]bool, numNodes)

	// Build the implication graph based on the 2-SAT formulation.
	// For NAND(i, j) = 1, it means (input[i] AND input[j]) = 0.
	// This implies (NOT input[i]) OR (NOT input[j]).
	// In 2-SAT, a clause (P OR Q) translates to implications (NOT P -> Q) and (NOT Q -> P).
	// Applying this to (NOT x_i OR NOT x_j):
	// 1. NOT (NOT x_i) -> NOT x_j  =>  x_i -> NOT x_j
	// 2. NOT (NOT x_j) -> NOT x_i  =>  x_j -> NOT x_i
	// Using our node mapping: x_k is node k, NOT x_k is node k+n.
	for _, op := range ops {
		i := op[0]
		j := op[1]
		// Add edge x_i -> NOT x_j
		adj[i] = append(adj[i], j+n)
		// Add edge x_j -> NOT x_i
		adj[j] = append(adj[j], i+n)
	}

	// Run Tarjan's algorithm to find all SCCs
	for i := 0; i < numNodes; i++ {
		if dfn[i] == 0 { // If node i has not been visited yet
			tarjanDFS(i)
		}
	}

	// Check for contradictions: if any variable x_k and its negation NOT x_k
	// are in the same SCC, then no valid assignment exists.
	for k := 0; k < n; k++ {
		if sccID[k] == sccID[k+n] {
			return false
		}
	}

	// If no contradictions are found, a valid assignment exists.
	return true
}