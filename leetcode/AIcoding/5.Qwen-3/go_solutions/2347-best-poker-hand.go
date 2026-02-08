package main

func bestHand(hands []int) string {
    count := make(map[int]int)
    for _, v := range hands {
        count[v]++
    }
    maxCount := 0
    for _, v := range count {
        if v > maxCount {
            maxCount = v
        }
    }
    if maxCount >= 5 {
        return "Flush"
    } else if maxCount == 4 {
        return "Four of a Kind"
    } else if maxCount == 3 {
        return "Three of a Kind"
    } else if maxCount == 2 {
        return "Pair"
    } else {
        return "High Card"
    }
}