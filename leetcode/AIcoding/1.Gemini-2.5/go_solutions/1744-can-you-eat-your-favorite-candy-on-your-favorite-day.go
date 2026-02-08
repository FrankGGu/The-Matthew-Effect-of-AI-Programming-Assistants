func canEat(candiesCount []int, queries [][]int) []bool {
    n := len(candiesCount)
    prefixSums := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefixSums[i+1] = prefixSums[i] + int64(candiesCount[i])
    }

    results := make([]bool, len(queries))
    for i, query := range queries {
        candyType := query[0]
        day := query[1]
        dailyCap := query[2]

        // Calculate the minimum and maximum total candies that could have been eaten by the end of 'day' (inclusive).
        // 'day' is 0-indexed, so (day + 1) represents the number of days passed.
        minCandiesEatenByDayEnd := int64(day) + 1
        maxCandiesEatenByDayEnd := (int64(day) + 1) * int64(dailyCap)

        // Condition 1: We must be able to reach 'candyType' by 'day'.
        // This means the maximum number of candies we *could* have eaten by the end of 'day'
        // must be at least the total count of candies *before* 'candyType'.
        // `prefixSums[candyType]` stores the sum of candies from type 0 to `candyType - 1`.
        canReachCandyType := maxCandiesEatenByDayEnd >= prefixSums[candyType]

        // Condition 2: We must not have finished all candies of 'candyType' by 'day'.
        // This means the minimum number of candies we *could* have eaten by the end of 'day'
        // must be strictly less than the total count of candies *up to and including* 'candyType'.
        // `prefixSums[candyType + 1]` stores the sum of candies from type 0 to `candyType`.
        notFinishedCandyType := minCandiesEatenByDayEnd < prefixSums[candyType+1]

        results[i] = canReachCandyType && notFinishedCandyType
    }

    return results
}