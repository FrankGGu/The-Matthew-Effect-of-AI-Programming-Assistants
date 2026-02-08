func numJewelsInStones(jewels string, stones string) int {
    jewelSet := make(map[rune]struct{})
    for _, j := range jewels {
        jewelSet[j] = struct{}{}
    }

    count := 0
    for _, s := range stones {
        if _, exists := jewelSet[s]; exists {
            count++
        }
    }

    return count
}