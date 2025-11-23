func stoneGameIII(stoneValue []int) string {
	n := len(stoneValue)
	// dp[i] stores the maximum score difference (Alice's score - Bob's score)
	// that Alice can achieve if the game starts from index i.
	//