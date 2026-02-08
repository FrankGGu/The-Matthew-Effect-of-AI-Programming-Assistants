package main

func numberOfWays(corridor string) int {
	sIndices := []int{}
	for i, char := range corridor {
		if char == 'S' {
			sIndices = append(sIndices, i)
		}
	}

	n := len(sIndices)
	if n == 0 || n%2 != 0 {
		return 0
	}

	MOD := 1_000_000_007
	ways := 1

	for i := 1; i < n-1; i += 2 {
		ways = (ways * (sIndices[i+1] - sIndices[i])) % MOD
	}

	return ways
}