func deckRevealedIncreasing(deck []int) []int {
    sort.Ints(deck)
    n := len(deck)
    result := make([]int, n)
    queue := make([]int, n)
    for i := 0; i < n; i++ {
        queue[i] = i
    }
    for _, card := range deck {
        idx := queue[0]
        queue = queue[1:]
        result[idx] = card
        if len(queue) > 0 {
            queue = append(queue, queue[0])
            queue = queue[1:]
        }
    }
    return result
}