import "math"

func minimumCardPickup(cards []int) int {
    cardIndices := make(map[int]int)
    minLen := math.MaxInt32

    for i, card := range cards {
        if prevIndex, found := cardIndices[card]; found {
            currentLen := i - prevIndex + 1
            if currentLen < minLen {
                minLen = currentLen
            }
        }
        cardIndices[card] = i
    }

    if minLen == math.MaxInt32 {
        return -1
    }
    return minLen
}