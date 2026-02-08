func canEat(candiesCount []int, queries [][]int) []bool {
	n := len(candiesCount)
	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(candiesCount[i])
	}

	result := make([]bool, len(queries))
	for i, query := range queries {
		favoriteType := query[0]
		favoriteDay := int64(query[1])
		dailyCap := int64(query[2])

		minCandies := favoriteDay + 1
		maxCandies := (favoriteDay + 1) * dailyCap

		availableCandiesBefore := prefixSum[favoriteType]
		availableCandiesAfter := prefixSum[favoriteType+1]

		if availableCandiesAfter < minCandies || availableCandiesBefore >= maxCandies {
			result[i] = false
		} else {
			result[i] = true
		}
	}

	return result
}