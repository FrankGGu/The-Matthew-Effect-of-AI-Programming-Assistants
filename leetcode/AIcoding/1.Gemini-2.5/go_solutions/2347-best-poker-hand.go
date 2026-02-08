func bestHand(ranks []int, suits []byte) string {
    // 1. Check for Flush
    isFlush := true
    for i := 1; i < len(suits); i++ {
        if suits[i] != suits[0] {
            isFlush = false
            break
        }
    }
    if isFlush {
        return "Flush"
    }

    // 2. Check for Three of a Kind, Pair, High Card
    rankCounts := make(map[int]int)
    for _, rank := range ranks {
        rankCounts[rank]++
    }

    hasThreeOfAKind := false
    hasPair := false

    for _, count := range rankCounts {
        if count >= 3 {
            hasThreeOfAKind = true
            // If we found 3 or more, it's at least "Three of a Kind".
            // No need to check for "Pair" if this is true, as "Three of a Kind" is better.
            break 
        }
        if count >= 2 {
            hasPair = true
        }
    }

    if hasThreeOfAKind {
        return "Three of a Kind"
    }
    if hasPair {
        return "Pair"
    }

    // If none of the above, it's a High Card
    return "High Card"
}