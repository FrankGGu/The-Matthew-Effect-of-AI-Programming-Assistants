func maxDecks(deck []int) int {
    count := make(map[int]int)
    for _, card := range deck {
        count[card]++
    }

    minCount := len(deck)
    for _, c := range count {
        if c < minCount {
            minCount = c
        }
    }

    return minCount
}