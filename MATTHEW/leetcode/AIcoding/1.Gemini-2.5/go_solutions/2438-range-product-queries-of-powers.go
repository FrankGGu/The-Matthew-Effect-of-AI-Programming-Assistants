func productQueries(n int, queries [][]int) []int {
	const MOD int = 1e9 + 7

	var powers []int
	tempN := n
	var p int = 1
	for tempN > 0 {
		if tempN&1 == 1 {
			powers = append(powers, p)
		}
		p *= 2
		tempN >>= 1
	}

	results := make([]int, len(queries))
	for i, query := range queries {
		left := query[0]
		right := query[1]

		currentProduct := 1
		for j := left; j <= right; j++ {
			currentProduct = (currentProduct * powers[j]) % MOD
		}
		results[i] = currentProduct
	}

	return results
}