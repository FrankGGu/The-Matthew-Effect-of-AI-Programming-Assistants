func distributeCandies(candyType []int) int {
    unique := make(map[int]bool)
    for _, t := range candyType {
        unique[t] = true
    }
    maxTypes := len(unique)
    maxAllowed := len(candyType) / 2
    if maxTypes < maxAllowed {
        return maxTypes
    }
    return maxAllowed
}