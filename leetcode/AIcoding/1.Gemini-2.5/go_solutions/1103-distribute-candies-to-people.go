func distributeCandies(candies int, num_people int) []int {
    result := make([]int, num_people)
    currentCandyAmount := 1
    personIndex := 0

    for candies > 0 {
        giveAmount := currentCandyAmount
        if candies < currentCandyAmount {
            giveAmount = candies
        }

        result[personIndex] += giveAmount
        candies -= giveAmount
        currentCandyAmount++
        personIndex = (personIndex + 1) % num_people
    }

    return result
}