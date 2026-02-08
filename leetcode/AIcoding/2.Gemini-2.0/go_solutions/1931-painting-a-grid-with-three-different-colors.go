func colorTheGrid(m int, n int) int {
	MOD := 1000000007

	var validStates []int
	var adj [][]bool

	var isValid func(state int) bool
	isValid = func(state int) bool {
		for i := 0; i < m-1; i++ {
			if (state/intPow(3, i))%3 == (state/intPow(3, i+1))%3 {
				return false
			}
		}
		return true
	}

	var generateStates func(idx int, state int)
	generateStates = func(idx int, state int) {
		if idx == m {
			if isValid(state) {
				validStates = append(validStates, state)
			}
			return
		}

		for i := 0; i < 3; i++ {
			generateStates(idx+1, state+i*intPow(3, idx))
		}
	}

	generateStates(0, 0)

	adj = make([][]bool, len(validStates))
	for i := range adj {
		adj[i] = make([]bool, len(validStates))
	}

	var areAdjacent func(state1 int, state2 int) bool
	areAdjacent = func(state1 int, state2 int) bool {
		for i := 0; i < m; i++ {
			if (state1/intPow(3, i))%3 == (state2/intPow(3, i))%3 {
				return false
			}
		}
		return true
	}

	for i := 0; i < len(validStates); i++ {
		for j := 0; j < len(validStates); j++ {
			if areAdjacent(validStates[i], validStates[j]) {
				adj[i][j] = true
			}
		}
	}

	dp := make([]int, len(validStates))
	for i := range dp {
		dp[i] = 1
	}

	for k := 1; k < n; k++ {
		newDp := make([]int, len(validStates))
		for i := 0; i < len(validStates); i++ {
			for j := 0; j < len(validStates); j++ {
				if adj[i][j] {
					newDp[i] = (newDp[i] + dp[j]) % MOD
				}
			}
		}
		dp = newDp
	}

	result := 0
	for i := 0; i < len(validStates); i++ {
		result = (result + dp[i]) % MOD
	}

	return result
}

func intPow(base, exponent int) int {
	result := 1
	for i := 0; i < exponent; i++ {
		result *= base
	}
	return result
}