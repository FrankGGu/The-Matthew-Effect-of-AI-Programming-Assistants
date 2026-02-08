func minimumCardPickup(cards []int) int {
    lastIndex := make(map[int]int)
    minLength := math.MaxInt32

    for i, card := range cards {
        if index, found := lastIndex[card]; found {
            minLength = min(minLength, i-index+1)
        }
        lastIndex[card] = i
    }

    if minLength == math.MaxInt32 {
        return -1
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}