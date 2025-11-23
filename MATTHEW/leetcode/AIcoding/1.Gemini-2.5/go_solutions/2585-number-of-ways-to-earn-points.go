package main

func numberOfWaysToEarnPoints(exams [][]int, target int) int {
	const MOD int = 1e9 + 7

	dp := make([]int, target+1)
	dp[0] = 1

	for _, exam := range exams {
		p := exam[0]
		c := exam[1]

		dpCurr := make([]int, target+1)

		for j := 0; j <= target; j++ {
			// Initialize dpCurr[j] with ways to get j points without using any instance of the current exam.
			// This is equivalent to dp[j] (from the previous exam's state).
			dpCurr[j] = dp[j]

			// If j >= p, we can potentially add ways by using one more instance of the current exam.
			// The term dpCurr[j-p] represents the sum of ways to get j-p points using 0 to k instances
			// of the current exam, where k is the number of instances used to reach j-p.
			// So, adding dpCurr[j-p] effectively adds:
			// dp[j-p] (using 1 of current exam)
			// + dp[j-2p] (using 2 of current exam)
			// ...
			// + dp[j-c*p] (using c of current exam)
			// This is the "unbounded knapsack" part.
			if j >= p {
				dpCurr[j] = (dpCurr[j] + dpCurr[j-p]) % MOD
			}

			// If j >= (c+1)*p, it means we have overcounted.
			// The dpCurr[j] (after the previous step) includes ways where more than 'c' instances
			// of the current exam were used. We need to subtract the ways that used exactly (c+1) instances.
			// This is done by subtracting dp[j-(c+1)*p], which represents the ways to get
			// j-(c+1)*p points using exams considered *before* the current one.
			// This effectively removes the (c+1)-th instance and higher.
			if j >= (c+1)*p {
				dpCurr[j] = (dpCurr[j] - dp[j-(c+1)*p] + MOD) % MOD
			}
		}
		dp = dpCurr // Update dp for the next iteration
	}

	return dp[target]
}