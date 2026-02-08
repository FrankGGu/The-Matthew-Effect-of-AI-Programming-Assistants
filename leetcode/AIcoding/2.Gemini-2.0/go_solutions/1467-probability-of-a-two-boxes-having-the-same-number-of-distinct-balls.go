func probability(balls []int) float64 {
	n := len(balls)
	totalBalls := 0
	for _, b := range balls {
		totalBalls += b
	}
	halfBalls := totalBalls / 2

	var dfs func(idx, sum, distinct int, box1Balls []int) float64
	dfs = func(idx, sum, distinct int, box1Balls []int) float64 {
		if idx == n {
			if sum == halfBalls {
				distinct2 := 0
				for i := 0; i < n; i++ {
					if balls[i]-box1Balls[i] > 0 {
						distinct2++
					}
				}
				if distinct == distinct2 {
					return combinations(halfBalls, box1Balls)
				}
			}
			return 0.0
		}

		res := 0.0
		for i := 0; i <= balls[idx]; i++ {
			newDistinct := distinct
			if i > 0 {
				newDistinct++
			}
			box1Balls[idx] = i
			res += dfs(idx+1, sum+i, newDistinct, box1Balls)
		}
		return res
	}

	totalCombinations := combinations(totalBalls, balls)
	box1Balls := make([]int, n)
	sameDistinctCombinations := dfs(0, 0, 0, box1Balls)

	return sameDistinctCombinations / totalCombinations
}

func combinations(total int, balls []int) float64 {
	res := 1.0
	sum := 0
	for _, b := range balls {
		res *= combinationsHelper(total-sum, b)
		sum += b
	}
	return res
}

func combinationsHelper(n, k int) float64 {
	if k == 0 {
		return 1.0
	}
	if k > n {
		return 0.0
	}
	if k > n/2 {
		k = n - k
	}
	res := 1.0
	for i := 1; i <= k; i++ {
		res = res * float64(n-i+1) / float64(i)
	}
	return res
}