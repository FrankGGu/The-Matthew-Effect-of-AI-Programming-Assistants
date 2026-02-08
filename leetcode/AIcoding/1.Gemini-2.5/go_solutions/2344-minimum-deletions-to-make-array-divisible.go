func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func gcdOfArray(arr []int) int {
	result := arr[0]
	for i := 1; i < len(arr); i++ {
		result = gcd(result, arr[i])
	}
	return result
}

func minOperations(nums []int, numsDivide []int) int {
	// Calculate the GCD of all elements in numsDivide.
	// Any number from nums that divides all elements in numsDivide must also divide their GCD.
	g := gcdOfArray(numsDivide)

	// Sort nums in ascending order.
	// This ensures that the first number we find that satisfies the condition
	// is the smallest one, thus requiring the minimum number of deletions.
	sort.Ints(nums)

	// Iterate through the sorted nums array.
	for i, num := range nums {
		// If the current number divides the GCD of numsDivide, it's a valid candidate.
		// Since nums is sorted, this is the smallest such number.
		// The number of deletions needed is its index in the sorted array.
		if g%num == 0 {
			return i
		}
	}

	// If no number in nums can divide the GCD of numsDivide,
	// it's impossible to satisfy the condition.
	return -1
}