package main

func mostPoints(questions [][]int) int64 {
	n := len(questions)
	if n == 0 {
		return 0
	}

	dp := make([]int64, n+1)

	for i := n - 1; i >= 0; i-- {
		solvePoints := int64(questions[i][0])
		nextQuestionIdx := i + questions[i][1] + 1

		if nextQuestionIdx <= n {
			solvePoints += dp[nextQuestionIdx]
		}

		skipPoints := dp[i+1]

		dp[i] = max(solvePoints, skipPoints)
	}

	return dp[0]
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}