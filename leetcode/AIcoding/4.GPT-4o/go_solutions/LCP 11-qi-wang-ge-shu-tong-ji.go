func expectNumber(cards []int) float64 {
    uniqueCards := make(map[int]bool)
    for _, card := range cards {
        uniqueCards[card] = true
    }
    return float64(len(uniqueCards))
}