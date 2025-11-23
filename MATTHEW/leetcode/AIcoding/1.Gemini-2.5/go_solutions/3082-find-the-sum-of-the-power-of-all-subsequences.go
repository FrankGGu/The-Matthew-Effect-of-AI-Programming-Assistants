func sumOfPower(nums []int, k int) int {
	const MOD = 1e9 + 7

	// dp[s] will store the number of subsequences that sum up to 's'.
	// The size of dp array should be k + 1.
	dp := make([]int, k+1)

	// Base case: An empty subsequence has a sum of 0. There is 1 such subsequence.
	dp[0] = 1

	// Iterate through each number in nums
	for _, num := range nums {
		// Iterate backwards from k down to num.
		// This ensures that each number is used at most once in a subsequence
		// (i.e., we don't use dp[s - num] which might have already included 'num' in its calculation for the current iteration).
		for s := k; s >= num; s-- {
			// To form a subsequence with sum 's':
			// We can either include 'num' or not include 'num'.
			// If we include 'num', the remaining elements must sum to 's - num'.
			// The number of ways to do this is dp[s - num].
			// If we don't include 'num', the sum 's' must be formed by previous numbers.
			// This is already represented by the current dp[s] value before this update.
			dp[s] = (dp[s] + dp[s-num]) % MOD
		}
	}

	// After iterating through all numbers, dp[k] contains the count of all subsequences
	// that sum up to exactly k.
	// The problem asks for the sum of powers of all such subsequences.
	// The power of a subsequence with sum k is k.
	// If there are dp[k] such subsequences, the total sum of their powers is dp[k] * k.

	// Ensure the multiplication result is also modulo MOD.
	result := (dp[k] * k) % MOD

	return result
}