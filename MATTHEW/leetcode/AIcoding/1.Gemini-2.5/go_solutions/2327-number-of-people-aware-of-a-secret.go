package main

func peopleAwareOfSecret(n int, delay int, forget int) int {
	mod := 1000000007

	// dp[i] stores the number of people who learned the secret on day i.
	dp := make([]int, n+1)

	// On day 1, one person learns the secret.
	dp[1] = 1

	// `sharingCount` keeps track of the number of people who are currently able to share the secret.
	// This is the sum of dp[k] for k in the window [i - forget + 1, i - delay].
	// This variable will represent the number of new people learning the secret on day `i`.
	sharingCount := 0

	// Iterate from day 2 up to day n.
	for i := 2; i <= n; i++ {
		// Add people who become able to share on day `i`.
		// These are people who learned the secret on day `i - delay`.
		if i-delay >= 1 {
			sharingCount = (sharingCount + dp[i-delay]) % mod
		}

		// Remove people who forget the secret on day `i`.
		// These are people who learned the secret on day `i - forget`.
		if i-forget >= 1 {
			sharingCount = (sharingCount - dp[i-forget] + mod) % mod
		}

		// The number of new people who learn the secret on day `i`
		// is equal to the number of people currently sharing the secret.
		dp[i] = sharingCount
	}

	// Calculate the total number of people aware of the secret on day `n`.
	// These are all people who learned the secret on day `j` such that
	// they have not forgotten it by day `n`.
	// A person who learned on day `j` forgets on day `j + forget`.
	// So, they are aware on day `n` if `j + forget > n`, which means `j > n - forget`.
	totalAware := 0
	// The loop starts from `n - forget + 1` because `forget <= n` implies `n - forget + 1 >= 1`.
	for i := n - forget + 1; i <= n; i++ {
		totalAware = (totalAware + dp[i]) % mod
	}

	return totalAware
}