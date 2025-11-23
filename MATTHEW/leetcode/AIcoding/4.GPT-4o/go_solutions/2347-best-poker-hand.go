func bestHand(ranks []int) string {
    count := make([]int, 14)
    for _, rank := range ranks {
        count[rank]++
    }

    maxCount := 0
    for _, c := range count {
        if c > maxCount {
            maxCount = c
        }
    }

    if maxCount >= 3 {
        return "Three of a Kind"
    } else if maxCount == 2 {
        return "One Pair"
    } else if maxCount == 1 {
        return "High Card"
    }
    return "No Hand"
}