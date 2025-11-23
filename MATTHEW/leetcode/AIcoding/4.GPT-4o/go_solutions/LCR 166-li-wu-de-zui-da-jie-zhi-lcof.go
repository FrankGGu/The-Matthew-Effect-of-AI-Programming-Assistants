func numJewelsInStones(jewels string, stones string) int {
    jewelSet := make(map[rune]struct{})
    for _, jewel := range jewels {
        jewelSet[jewel] = struct{}{}
    }

    count := 0
    for _, stone := range stones {
        if _, exists := jewelSet[stone]; exists {
            count++
        }
    }

    return count
}