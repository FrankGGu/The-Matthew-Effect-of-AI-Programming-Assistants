func bestHand(ranks []int, suits []byte) string {
    flush := true
    for i := 1; i < len(suits); i++ {
        if suits[i] != suits[0] {
            flush = false
            break
        }
    }
    if flush {
        return "Flush"
    }

    rankCount := make(map[int]int)
    for _, r := range ranks {
        rankCount[r]++
    }

    maxCount := 0
    for _, count := range rankCount {
        if count > maxCount {
            maxCount = count
        }
    }

    if maxCount >= 3 {
        return "Three of a Kind"
    } else if maxCount == 2 {
        return "Pair"
    } else {
        return "High Card"
    }
}