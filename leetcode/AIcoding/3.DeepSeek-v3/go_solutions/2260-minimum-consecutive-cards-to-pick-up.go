func minimumCardPickup(cards []int) int {
    lastPos := make(map[int]int)
    minDistance := -1

    for i, card := range cards {
        if pos, exists := lastPos[card]; exists {
            distance := i - pos + 1
            if minDistance == -1 || distance < minDistance {
                minDistance = distance
            }
        }
        lastPos[card] = i
    }

    return minDistance
}