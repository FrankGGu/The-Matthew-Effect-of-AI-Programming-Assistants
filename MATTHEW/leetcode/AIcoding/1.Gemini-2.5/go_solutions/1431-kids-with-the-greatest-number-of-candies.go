func kidsWithCandies(candies []int, extraCandies int) []bool {
    maxCandies := 0
    for _, candy := range candies {
        if candy > maxCandies {
            maxCandies = candy
        }
    }

    result := make([]bool, len(candies))
    for i, candy := range candies {
        result[i] = (candy + extraCandies) >= maxCandies
    }

    return result
}