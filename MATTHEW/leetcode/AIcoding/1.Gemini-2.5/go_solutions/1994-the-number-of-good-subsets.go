func numberOfGoodSubsets(nums []int) int {
	const MOD = 1_000_000_007

	// Primes up to 30
	primes := []int{2, 3, 5, 7, 11