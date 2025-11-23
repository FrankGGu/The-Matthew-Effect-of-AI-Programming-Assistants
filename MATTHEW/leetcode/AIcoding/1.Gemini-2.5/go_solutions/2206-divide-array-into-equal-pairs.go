func divideArray(nums []int) bool {
	// A frequency map to store counts of each number.
	// Given nums[i] <= 500, an array can be used as a frequency counter
	// instead of a hash map for potentially better performance and constant space.
	// The size should be max_val + 1, which is 501 for values up to 500.
	counts := make([]int, 501)

	// Populate the frequency map by iterating through the input array.
	// This loop runs in O(N) time, where N is the length of nums.
	for _, num := range nums {
		counts[num]++
	}

	// Check if all counts in the frequency map are even.
	// This loop runs in O(M) time, where M is the range of possible values (501).
	// Since M is a constant, this part is effectively O(1).
	for _, count := range counts {
		// If any number appears an odd number of times, it's impossible to form
		// pairs of identical elements for all occurrences of that number.
		// Therefore, the array cannot be divided into equal pairs.
		if count%2 != 0 {
			return false
		}
	}

	// If we reach this point, it means every number in the input array appeared
	// an even number of times. This guarantees that each number can be paired
	// with an identical twin, allowing the entire array to be divided into
	// n/2 pairs where each pair (a, b) has a == b.
	return true
}