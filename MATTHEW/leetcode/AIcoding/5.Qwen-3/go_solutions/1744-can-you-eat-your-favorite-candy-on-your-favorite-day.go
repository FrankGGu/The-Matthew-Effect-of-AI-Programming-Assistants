package main

func canEat(candyType []int, dailyCap []int, favoriteDay int) bool {
    candyCount := make(map[int]bool)
    for _, typ := range candyType {
        candyCount[typ] = true
    }
    uniqueCandies := len(candyCount)
    return uniqueCandies <= dailyCap[favoriteDay]
}