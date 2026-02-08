func deckRevealedIncreasing(deck []int) []int {
    sort.Ints(deck)
    n := len(deck)
    ans := make([]int, n)
    queue := []int{}

    for i := 0; i < n; i++ {
        queue = append(queue, i)
    }

    for _, card := range deck {
        ans[queue[0]] = card
        queue = queue[1:]
        if len(queue) > 0 {
            queue = append(queue, queue[0])
            queue = queue[1:]
        }
    }

    return ans
}