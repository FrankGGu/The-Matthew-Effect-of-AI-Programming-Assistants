package main

func distributeCandies(candies int, num_people int) []int {
    result := make([]int, num_people)
    i := 0
    give := 1
    for candies > 0 {
        if i >= num_people {
            i = 0
        }
        if give <= candies {
            result[i] += give
            candies -= give
            give++
        } else {
            result[i] += candies
            candies = 0
        }
        i++
    }
    return result
}