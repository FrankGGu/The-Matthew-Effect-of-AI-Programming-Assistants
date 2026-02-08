func distributeCandies(candies []int) int {
    candyTypes := make(map[int]bool)
    for _, candy := range candies {
        candyTypes[candy] = true
    }
    if len(candyTypes) > len(candies)/2 {
        return len(candies) / 2
    }
    return len(candyTypes)
}