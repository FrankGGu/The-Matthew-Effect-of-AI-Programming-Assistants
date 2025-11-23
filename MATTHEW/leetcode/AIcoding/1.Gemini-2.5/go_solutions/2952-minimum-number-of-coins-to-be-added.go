func minPatches(coins []int, target int) int {
	patches := 0
	var reach int64 = 0 // Use int64 for reach to avoid overflow, as target can be 10^9
	i := 0              // Pointer for coins array
	n := len(coins)

	for reach < int64(target) {
		if i < n && int64(coins[i]) <= reach+1 {
			// If the current coin can extend our reach without a gap
			reach += int64(coins[i])
			i++
		} else {
			// We need to add a coin to cover the gap (reach + 1)
			// The most efficient coin to add is reach + 1 itself
			reach += (reach + 1)
			patches++
		}
	}

	return patches
}