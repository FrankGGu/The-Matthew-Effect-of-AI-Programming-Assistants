func numberOfBeautifulPartitions(s string, k int, minLength int) int {
	n := len(s)
	MOD := 1_000_000_007

	// Early exit for impossible cases
	// If the total length required for k partitions of minLength is greater than n.
	if k*minLength > n {
		return 0
	}
	// The first character of the entire string must be a prime digit
	// because it starts the first partition.
	if !isPrime(s[0]) {
		return 0
	}
	// The last character of the entire string must be a non-prime digit
	// because it ends the last partition.
	if isPrime(s[n-1]) {
		return 0
	}

	// isPrimeChar[i] is true if s[i] is a prime digit, false otherwise.
	isPrimeChar := make([]bool, n)
	for i := 0; i < n; i++ {
		isPrimeChar[i] = isPrime(s[i])
	}

	// dp_prev_k stores dp[...][j-1] values (number of ways to partition prefix into j-1 parts)
	// dp_curr_k stores dp[...][j] values (number of ways to partition prefix into j parts)
	// dp[i][j] represents the number of ways to partition s[0...i-1] into j beautiful substrings.
	// i is the length of the prefix, ranging from 0 to n.
	// dp_prev_k[0] = 1 represents the base case: 0 prefix, 0 partitions, 1 way.
	dp_prev_k := make([]int, n+1)
	dp_prev_k[0] = 1

	// Loop for the number of partitions (j) from 1 to k.
	for j := 1; j <= k; j++ {
		dp_curr_k := make([]int, n+1)
		// current_sum_of_prime_starts accumulates dp_prev_k[p] for valid p where s[p] is prime.
		// p is the starting index of the current (j-th) substring.
		// p is also the length of the prefix s[0...p-1] that was partitioned into j-1 parts.
		current_sum_of_prime_starts := 0

		// Loop for the length of the current prefix (i) from 1 to n.
		// i represents the end of the current (j-th) partition (s[i-1]).
		for i := 1; i <= n; i++ {
			// Update current_sum_of_prime_starts.
			// The current substring starts at index `p_start`.
			// The length of the current substring is `i - p_start`.
			// `i - p_start >= minLength` implies `p_start <= i - minLength`.
			// So, `p_start` values up to `i - minLength` are considered.
			// When `i` increments, a new `p_start` candidate becomes `i - minLength`.
			// We add `dp_prev_k[i-minLength]` to the running sum if `s[i-minLength]` is prime.
			p_candidate := i - minLength
			if p_candidate >= 0 { // Ensure p_candidate is a valid index.
				if isPrimeChar[p_candidate] { // If s[p_candidate] is a prime digit.
					current_sum_of_prime_starts = (current_sum_of_prime_starts + dp_prev_k[p_candidate]) % MOD
				}
			}

			// Calculate dp_curr_k[i].
			// The current substring ends at s[i-1].
			// Condition: s[i-1] must be a non-prime digit.
			if !isPrimeChar[i-1] {
				dp_curr_k[i] = current_sum_of_prime_starts
			}
		}
		dp_prev_k = dp_curr_k // Move to the next partition count.
	}

	return dp_prev_k[n]
}

func isPrime(char byte) bool {
	switch char {
	case '2', '3', '5', '7':
		return true
	default:
		return false
	}
}