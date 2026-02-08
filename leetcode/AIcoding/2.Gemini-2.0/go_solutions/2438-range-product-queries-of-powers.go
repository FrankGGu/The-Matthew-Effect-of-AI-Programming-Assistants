func productQueries(n int, queries [][]int) []int {
	powers := []int{}
	for i := 0; n > 0; i++ {
		if n%2 == 1 {
			powers = append(powers, int(1)<<i)
		}
		n /= 2
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		prod := 1
		for j := query[0]; j <= query[1]; j++ {
			prod = (prod * powers[j]) % 1000000007
		}
		result[i] = prod
	}

	return result
}