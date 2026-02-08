func canEat(candiesCount []int, queries [][]int) []bool {
    prefixSum := make([]int, len(candiesCount)+1)
    for i := 1; i <= len(candiesCount); i++ {
        prefixSum[i] = prefixSum[i-1] + candiesCount[i-1]
    }

    result := make([]bool, len(queries))
    for i, query := range queries {
        favoriteType := query[0]
        favoriteDay := query[1]
        dailyCap := query[2]

        totalCandiesBefore := prefixSum[favoriteType]
        totalCandiesAfter := prefixSum[favoriteType+1]

        minCandiesNeeded := favoriteDay + 1
        maxCandiesAllowed := dailyCap * (favoriteDay + 1)

        result[i] = !(minCandiesNeeded > totalCandiesAfter || maxCandiesAllowed < totalCandiesBefore)
    }

    return result
}