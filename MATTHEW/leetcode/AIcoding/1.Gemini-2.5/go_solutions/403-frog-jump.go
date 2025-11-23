package main

func canCross(stones []int) bool {
	// Problem constraints: 2 <= stones.length <= 2000
	// stones[0] == 0

	// If the second stone is not at position 1, the first jump of 1 unit is impossible.
	if stones[1] != 1 {
		return false
	}

	stoneMap := make(map[int]bool)
	for _, s := range stones {
		stoneMap[s] = true
	}

	// dp[stone_position] stores a set of possible jump_units that can land on this stone_position.
	// outer map: stone position -> inner map
	// inner map: jump unit -> true (indicating this jump unit can reach the stone)
	dp := make(map[int]map[int]bool)

	// Initialize the state after the first mandatory jump.
	// From stone 0, we must jump 1 unit to stone 1.
	dp[1] = make(map[int]bool)
	dp[1][1] = true // Stone 1 is reachable with a jump of 1 unit.

	// Iterate through each stone starting from the second stone (index 1).
	// The first stone (index 0) is implicitly handled by the initialization.
	for i := 1; i < len(stones); i++ {
		currentStonePos := stones[i]

		// Iterate through all possible jump units that can reach currentStonePos.
		for prevJump := range dp[currentStonePos] {
			// For a jump of 'prevJump' units to reach currentStonePos,
			// the next jump can be prevJump-1, prevJump, or prevJump+1.
			for nextJump := prevJump - 1; nextJump <= prevJump + 1; nextJump++ {
				if nextJump > 0 { // Jump distance must be positive.
					nextStonePos := currentStonePos + nextJump
					if stoneMap[nextStonePos] {
						if dp[nextStonePos] == nil {
							dp[nextStonePos] = make(map[int]bool)
						}
						dp[nextStonePos][nextJump] = true
					}
				}
			}
		}
	}

	// If the last stone has any entry in its map, it means it's reachable.
	return len(dp[stones[len(stones)-1]]) > 0
}