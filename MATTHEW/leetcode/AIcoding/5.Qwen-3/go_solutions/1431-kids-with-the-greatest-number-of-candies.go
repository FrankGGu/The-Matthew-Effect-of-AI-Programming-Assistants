package main

func kidsWithCandies(maxCandies int, candies []int) []bool {
    max := 0
    for _, c := range candies {
        if c > max {
            max = c
        }
    }
    result := make([]bool, len(candies))
    for i, c := range candies {
        result[i] = c+maxCandies >= max
    }
    return result
}