package main

import (
	"container/list"
	"fmt"
	"math"
	"sort"
	"strconv"
	"strings"
)

type State struct {
	k         int
	ops       int
	usedCoeffs []int // Sorted list of used coefficients
}

func hashUsedCoeffs(coeffs []int) string {
	if len(coeffs) == 0 {
		return "[]"
	}
	var sb strings.Builder
	sb.WriteByte('[')
	for i, c := range coeffs {
		if i > 0 {
			sb.WriteByte(',')
		}
		sb.WriteString(strconv.Itoa(c))
	}
	sb.WriteByte(']')
	return sb.String()
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minOperations(n int, k int) int {
	// M_BOUND is an empirical limit on the maximum number of distinct coefficients
	// we are allowed to use. For k up to 10^9, log2(k) is about 30.
	// Using significantly more coefficients than log2(k) is usually not optimal
	// because doubling is very efficient. A bound of 40-50 should be sufficient.
	const M_BOUND = 40

	// minOpsMap stores the minimum operations to reach a state (k, usedCoeffs).
	// The key for usedCoeffs is its string hash.
	// map[current_k]map[hash_of_used_coeffs_list]min_operations
	minOpsMap := make(map[int]map[string]int)

	// BFS queue
	q := list.New()

	// Initial state: target k, 0 operations, no coefficients used.
	initialUsedCoeffs := []int{}
	q.PushBack(State{k, 0, initialUsedCoeffs})

	// Initialize minOpsMap for the starting state
	minOpsMap[k] = make(map[string]int)
	minOpsMap[k][hashUsedCoeffs(initialUsedCoeffs)] = 0

	minGlobalOps := math.MaxInt32

	for q.Len() > 0 {
		curr := q.Remove(q.Front()).(State)
		currK := curr.k
		currOps := curr.ops
		currUsed := curr.used

		// If we reached 0, update global minimum and continue.
		if currK == 0 {
			minGlobalOps = min(minGlobalOps, currOps)
			continue
		}

		// Pruning: if current operations already exceed global minimum, no need to explore further.
		if currOps >= minGlobalOps {
			continue
		}
		// Pruning: if too many coefficients are used, it's likely not optimal.
		// This limits the branching factor for 'subtract' operations.
		if len(currUsed) > M_BOUND {
			continue
		}

		// Option 1: Divide by 2
		if currK%2 == 0 {
			nextK := currK / 2
			nextOps := currOps + 1
			usedKey := hashUsedCoeffs(currUsed)

			// Check if this state has been visited with fewer operations
			if _, ok := minOpsMap[nextK]; !ok {
				minOpsMap[nextK] = make(map[string]int)
			}
			if val, ok := minOpsMap[nextK][usedKey]; !ok || nextOps < val {
				minOpsMap[nextK][usedKey] = nextOps
				q.PushBack(State{nextK, nextOps, currUsed})
			}
		}

		// Option 2: Subtract a coefficient 'c'
		// We need to try various 'c' values. Iterating 1 to 'n' is too slow.
		// The strategy is to consider a small set of "most promising" 'c' values:
		// 1. Smallest coefficients (1, 2, ..., M_BOUND) if they are <= n.
		//    These are often used to adjust parity or chip away small amounts.
		// 2. 'currK' itself, if 'currK <= n'. This reaches 0 in one step.
		// 3. 'currK - 1', if 'currK - 1 <= n'. This makes 'currK' even, allowing division.
		// This set of candidates keeps the branching factor small.

		// Create a temporary map for quick lookup of used coefficients
		usedSet := make(map[int]bool)
		for _, c := range currUsed {
			usedSet[c] = true
		}

		potentialCs := make(map[int]bool) // Use a map to avoid duplicates and ensure unique candidates

		// Add small coefficients
		for c := 1; c <= M_BOUND && c <= n; c++ {
			if !usedSet[c] {
				potentialCs[c] = true
			}
		}
		// Add currK itself if it's a valid coefficient
		if currK >= 1 && currK <= n && !usedSet[currK] {
			potentialCs[currK] = true
		}
		// Add currK-1 if it's a valid coefficient
		if currK-1 >= 1 && currK-1 <= n && !usedSet[currK-1] {
			potentialCs[currK-1] = true
		}
		// Add currK-2 if it's a valid coefficient (sometimes useful for parity or small adjustments)
		if currK-2 >= 1 && currK-2 <= n && !usedSet[currK-2] {
			potentialCs[currK-2] = true
		}

		// Convert potentialCs map to a sorted slice for consistent iteration
		sortedPotentialCs := make([]int, 0, len(potentialCs))
		for c := range potentialCs {
			sortedPotentialCs = append(sortedPotentialCs, c)
		}
		sort.Ints(sortedPotentialCs)

		for _, c := range sortedPotentialCs {
			// Check if c is valid for subtraction
			if c > n || usedSet[c] || currK-c < 0 {
				continue // Should not happen with current logic, but good for safety
			}

			nextK := currK - c
			nextOps := currOps + 1

			// Create a new usedCoeffs slice for the next state
			nextUsed := make([]int, len(currUsed))
			copy(nextUsed, currUsed)
			nextUsed = append(nextUsed, c)
			sort.Ints(nextUsed) // Keep it sorted for consistent hashing

			usedKey := hashUsedCoeffs(nextUsed)

			// Check if this state has been visited with fewer operations
			if _, ok := minOpsMap[nextK]; !ok {
				minOpsMap[nextK] = make(map[string]int)
			}
			if val, ok := minOpsMap[nextK][usedKey]; !ok || nextOps < val {
				minOpsMap[nextK][usedKey] = nextOps
				q.PushBack(State{nextK, nextOps, nextUsed})
			}
		}
	}

	if minGlobalOps == math.MaxInt32 {
		return -1
	}
	return minGlobalOps
}

func volunteerDeployment(n int, k int) int {
	return minOperations(n, k)
}