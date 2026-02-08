func distributeCandies(candies int, num_people int) []int {
    result := make([]int, num_people)
    i := 0
    current := 1
    for candies > 0 {
        if candies >= current {
            result[i] += current
            candies -= current
        } else {
            result[i] += candies
            candies = 0
        }
        i = (i + 1) % num_people
        current++
    }
    return result
}