package main

func power(base, exp int) int {
	res := 1
	MOD := 1000000007
	base %= MOD
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % MOD
		}
		base = (base * base) % MOD
		exp /= 2
	}
	return res
}

func inverse(n int) int {
	return power(n, 1000000007-2)
}

func findNthValue(n int, k int) int {
	MOD := 1000000007

	// The problem asks for the N-th value (1-indexed).
	// Let's denote the 0-indexed position as `idx = n - 1`.
	// The value at `arr[idx]` after `k` seconds is given by the combination formula:
	// C(idx + k, k)
	// which is equivalent to C(idx + k, idx)
	// Substituting `idx = n - 1`, we get C(n - 1 + k, k)

	// Calculate the maximum value for n+k-1 to size the precomputation arrays.
	maxVal := n + k - 1

	fact := make([]int, maxVal+1)
	invFact := make([]int, maxVal+1)

	fact[0] = 1
	for i := 1; i <= maxVal; i++ {
		fact[i] = (fact[i-1] * i) % MOD
	}

	invFact[maxVal] = inverse(fact[maxVal])
	for i := maxVal - 1; i >= 0; i-- {
		invFact[i] = (invFact[i+1] * (i + 1)) % MOD
	}

	// C(N_val, K_val) = N_val! * (K_val!)^-1 * ((N_val - K_val)!)^-1 mod MOD
	// Here, N_val = n + k - 1
	// K_val = k
	// N_val - K_val = (n + k - 1) - k = n - 1

	numerator := fact[maxVal] // fact[n + k - 1]

	// denominator part: (k!)^-1 * ((n-1)!)^-1
	denominatorInv := (invFact[k] * invFact[n-1]) % MOD

	result := (numerator * denominatorInv) % MOD

	return result
}