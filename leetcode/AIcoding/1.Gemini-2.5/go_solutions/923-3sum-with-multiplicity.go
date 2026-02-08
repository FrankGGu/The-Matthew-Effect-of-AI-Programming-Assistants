func threeSumMulti(arr []int, target int) int {
	const MOD = 1_000_000_007

	// Use a frequency map/array since arr[i] values are small (0 to 100)
	counts := make([]int, 101)