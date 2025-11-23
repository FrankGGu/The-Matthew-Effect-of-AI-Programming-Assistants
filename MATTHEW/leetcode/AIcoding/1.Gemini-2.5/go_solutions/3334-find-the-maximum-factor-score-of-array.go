func calculateFactorScore(n int) int {
	if n == 1 {
		return 0
	}

	score := 0
	primeFactors := make(map[int]bool)

	if n%2 == 0 {
		primeFactors[2] = true
		for n%2 == 0 {
			n /= 2
		}
	}

	for i := 3; i*i <= n; i += 2 {
		if n%i == 0 {
			primeFactors[i] = true
			for n%i == 0 {
				n /= i
			}
		}
	}

	if n > 1 {
		primeFactors[n] = true
	}

	for p := range primeFactors {
		score += p
	}

	return score
}

func maxFactorScore(nums []int) int {
	maxS := 0
	for _, num := range nums {
		currentS := calculateFactorScore(num)
		if currentS > maxS {
			maxS = currentS
		}
	}
	return maxS
}