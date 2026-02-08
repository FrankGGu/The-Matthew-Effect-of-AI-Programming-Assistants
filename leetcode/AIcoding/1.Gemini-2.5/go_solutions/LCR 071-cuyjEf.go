type Solution struct {
	prefixSums []int
	totalSum   int
}

func Constructor(w []int) Solution {
	// Seed the random number generator once per Solution instance.
	// This ensures that subsequent calls to PickIndex within the same Solution object
	// produce different random sequences.
	rand.Seed(time.Now().UnixNano())

	prefixSums := make([]int, len(w))
	currentSum := 0
	for i, weight := range w {
		currentSum += weight
		prefixSums[i] = currentSum
	}

	return Solution{
		prefixSums: prefixSums,
		totalSum:   currentSum,
	}
}

func (this *Solution) PickIndex() int {
	// Generate a random integer between 1 and totalSum (inclusive).
	// rand.Intn(n) generates a number from 0 to n-1. Adding 1 shifts it to 1 to n.
	target := rand.Intn(this.totalSum) + 1

	// Use binary search to find the smallest index `i` such that `prefixSums[i] >= target`.
	// `sort.SearchInts` returns the index `i` of the first element in `prefixSums`
	// that is greater than or equal to `target`. This is exactly what we need for
	// weighted random selection.
	idx := sort.SearchInt