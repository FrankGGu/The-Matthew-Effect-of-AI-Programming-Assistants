func numFactoredBinaryTrees(arr []int) int {
	const MOD = 1_000_000_007

	// 1. Sort the input array to efficiently find factors.
	sort.Ints(arr)

	// 2. Initialize a map to