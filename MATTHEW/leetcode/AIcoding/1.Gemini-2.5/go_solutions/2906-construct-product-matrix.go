package main

func constructProductMatrix(grid [][]int) [][]int {
	R := len(grid)
	C := len(grid[0])
	MOD := 12345

	flatGrid := make([]int, R*C)
	idx := 0
	for r := 0; r < R; r++ {
		for c := 0; c < C; c++ {
			flatGrid[idx] = grid[r][c]
			idx++
		}
	}

	N := len(flatGrid)
	prefixProducts := make([]int, N)
	suffixProducts := make([]int, N)

	if N > 0 {
		prefixProducts[0] = flatGrid[0] % MOD
		for i := 1; i < N; i++ {
			prefixProducts[i] = (prefixProducts[i-1] * (flatGrid[i] % MOD)) % MOD
		}

		suffixProducts[N-1] = flatGrid[N-1] % MOD
		for i := N - 2; i >= 0; i-- {
			suffixProducts[i] = (suffixProducts[i+1] * (flatGrid[i] % MOD)) % MOD
		}
	}

	P := make([][]int, R)
	for r := 0; r < R; r++ {
		P[r] = make([]int, C)
		for c := 0; c < C; c++ {
			k := r*C + c

			leftProduct := 1
			if k > 0 {
				leftProduct = prefixProducts[k-1]
			}

			rightProduct := 1
			if k < N-1 {
				rightProduct = suffixProducts[k+1]
			}

			P[r][c] = (leftProduct * rightProduct) % MOD
		}
	}

	return P
}