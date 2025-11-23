import "math"

func minimumOperations(leaves string) int {
	n := len(leaves)

	// dp0: minimum operations to make leaves[0...i] all 'r's
	// dp1: minimum operations to make leaves[0...i] as 'r...ry...y'
	// dp2: minimum operations to make leaves[0...i] as 'r...ry...yr...r'

	// Initialize dp states for the first leaf (i=0)
	// For leaves[0], it must be part of the first 'r' section.
	// Cost to make leaves[0] an 'r'
	dp0 := 0
	if leaves[0] == 'y' {
		dp0 = 1
	}

	// For leaves[0], it cannot be the start of a 'y' section (needs preceding 'r')
	// or the start of the final 'r' section (needs preceding 'r...ry...y')
	dp1 := math.MaxInt32
	dp2 := math.MaxInt32

	for i := 1; i < n; i++ {
		costR := 0 // Cost to make leaves[i] an 'r'
		if leaves[i] == 'y' {
			costR = 1
		}
		costY := 0 // Cost to make leaves[i] a 'y'
		if leaves[i] == 'r' {
			costY = 1
		}

		// Calculate new dp states for current leaf i
		newDp0 := dp0 + costR

		// To form 'r...ry...y' at leaves[i]:
		// 1. Extend 'r...ry...y' from leaves[i-1] (dp1)
		// 2. Start 'y' section from 'r...r' at leaves[i-1] (dp0)
		// We use float64 for math.Min and then cast back to int.
		newDp1 := int(math.Min(float64(dp0), float64(dp1))) + costY

		// To form 'r...ry...yr...r' at leaves[i]:
		// 1. Extend 'r...ry...yr...r' from leaves[i-1] (dp2)
		// 2. Start final 'r' section from 'r...ry...y' at leaves[i-1] (dp1)
		// This state is only reachable if dp1 was reachable.
		newDp2 := int(math.Min(float64(dp1), float64(dp2))) + costR

		// Update dp states for next iteration
		dp0 = newDp0
		dp1 = newDp1
		dp2 = newDp2
	}

	// The final answer is dp2 for the last leaf (n-1)
	return dp2
}