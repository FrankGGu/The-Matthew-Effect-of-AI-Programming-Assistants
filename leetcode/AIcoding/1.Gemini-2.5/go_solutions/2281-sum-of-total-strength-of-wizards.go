package main

func totalStrength(strength []int) int {
	n := len(strength)
	MOD := 1_000_000_007

	P := make([]int, n+1)
	for i := 0; i < n; i++ {
		P[i+1] = (P[i] + strength[i]) % MOD
	}

	P2 := make([]int, n+2)
	for i := 0; i < n+1; i++ {
		P2[i+1] = (P2[i] + P[i]) % MOD
	}

	left := make([]int, n)
	stack := []int{}
	for i := 0; i < n; i++ {
		for len(stack) > 0 && strength[stack[len(stack)-1]] >= strength[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			left[i] = -1
		} else {
			left[i] = stack[len(stack)-1]
		}
		stack = append(stack, i)
	}

	right := make([]int, n)
	stack = []int{}
	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && strength[stack[len(stack)-1]] > strength[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			right[i] = n
		} else {
			right[i] = stack[len(stack)-1]
		}
		stack = append(stack, i)
	}

	totalStrengthSum := 0
	for i := 0; i < n; i++ {
		L := left[i] + 1
		R := right[i] - 1

		lenLeft := i - L + 1
		sumRightPrefixes := (P2[R+2] - P2[i+1] + MOD) % MOD
		term1 := (lenLeft * sumRightPrefixes) % MOD

		lenRight := R - i + 1
		sumLeftPrefixes := (P2[i+1] - P2[L] + MOD) % MOD
		term2 := (lenRight * sumLeftPrefixes) % MOD

		currentMinSum := (term1 - term2 + MOD) % MOD

		totalStrengthSum = (totalStrengthSum + (strength[i] * currentMinSum) % MOD) % MOD
	}

	return totalStrengthSum
}