package main

func deckRevealedInOrder(deck []int) []int {
    n := len(deck)
    result := make([]int, n)
    indices := make([]int, n)
    for i := 0; i < n; i++ {
        indices[i] = i
    }

    sort.Ints(indices)

    resIndex := 0
    for _, idx := range indices {
        result[idx] = deck[resIndex]
        resIndex++
    }

    return result
}