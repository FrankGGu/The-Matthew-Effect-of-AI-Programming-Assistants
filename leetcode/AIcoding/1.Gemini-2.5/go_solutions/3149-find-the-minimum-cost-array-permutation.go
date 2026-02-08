import (
	"math"
	"math/bits"
)

func findMinimumCost(n int, cost [][]int) int {
	// dp[mask][lastVal] stores the minimum cost to form a permutation prefix
	// where 'mask' represents the set of values used, and 'lastVal' is the last value in the prefix.
	// The length of the prefix is implicitly bits.OnesCount(mask).

	// Initialize dp table with a large value (infinity)
	const INF = math.MaxInt64 / 2 // Use half to prevent overflow during addition

	// dp table is reused for each starting value, so it's declared outside the loop,
	// but its contents are reset.
	dp := make([][]int, 1<<n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	minTotalCost := INF

	// Iterate through all possible starting values for p[0]
	for startVal := 0; startVal < n; startVal++ {
		// Reset dp table for each startVal
		for i := range dp {
			for j := range dp[i] {
				dp[i][j] = INF
			}
		}

		// Base case: p[0] = startVal
		// The initial cost for p[0] is cost[0][startVal]
		dp[1<<startVal][startVal] = cost[0][startVal]

		// Iterate through all possible masks.
		// A mask represents the set of values (0 to n-1) that have been used so far
		// in the permutation prefix p[0], ..., p[idx-1].
		for mask := 1; mask < (1 << n); mask++ {
			// idx is the current length of the permutation prefix (number of values assigned).
			// If idx = k, it means p[0]...p[k-1] have been assigned.
			// The next value will be assigned to p[k].
			idx := bits.OnesCount(uint(mask))
			if idx == 0 || idx == n {
				// idx=0 means an empty mask, which is not a valid state to start from here.
				// idx=n means all values have been used, so no further transitions from this mask.
				continue
			}

			// Iterate through all possible last values (p[idx-1]) in the current permutation prefix
			for prevVal := 0; prevVal < n; prevVal++ {
				// If prevVal is not part of the current mask or dp[mask][prevVal] is not reachable, skip
				if (mask&(1<<prevVal)) == 0 || dp[mask][prevVal] == INF {
					continue
				}

				// Try to add a new value (currVal) to the permutation at index 'idx' (i.e., p[idx] = currVal)
				for currVal := 0; currVal < n; currVal++ {
					// If currVal is already in the mask, skip (cannot reuse values)
					if (mask&(1<<currVal)) != 0 {
						continue
					}

					newMask := mask | (1 << currVal)

					// Calculate the cost for placing currVal at p[idx]:
					// This includes cost[idx][p[idx]] (which is cost[idx][currVal])
					// and cost[p[idx-1]][p[idx]] (which is cost[prevVal][currVal]).
					currentPathCost := dp[mask][prevVal] + cost[idx][currVal] + cost[prevVal][currVal]

					if currentPathCost < dp[newMask][currVal] {
						dp[newMask][currVal] = currentPathCost
					}
				}
			}
		}

		// After filling the dp table for a fixed startVal, calculate the total cost.
		// The final mask should have all bits set, indicating all values 0 to n-1 have been used.
		finalMask := (1 << n) - 1
		for lastVal := 0; lastVal < n; lastVal++ {
			if dp[finalMask][lastVal] != INF {
				// Add the final cycle cost: cost[p[n-1]][p[0]], which is cost[lastVal][startVal].
				totalCost := dp[finalMask][lastVal] + cost[lastVal][startVal]
				if totalCost < minTotalCost {
					minTotalCost = totalCost
				}
			}
		}
	}

	return minTotalCost
}