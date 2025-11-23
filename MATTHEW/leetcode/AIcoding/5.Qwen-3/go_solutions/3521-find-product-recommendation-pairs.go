package main

func findProductRecommendationPairs(purchases []int) []int {
    count := make(map[int]int)
    for _, p := range purchases {
        count[p]++
    }
    var result []int
    for k := range count {
        if count[k] >= 2 {
            result = append(result, k)
        }
    }
    return result
}