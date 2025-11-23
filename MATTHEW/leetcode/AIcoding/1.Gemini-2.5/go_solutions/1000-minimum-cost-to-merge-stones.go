func mergeStones(stones []int, k int) int {
	n := len(stones)

	// If it's impossible to merge all stones into one pile, return -1.
	// Each merge operation reduces the number of piles by (k - 1).
	//