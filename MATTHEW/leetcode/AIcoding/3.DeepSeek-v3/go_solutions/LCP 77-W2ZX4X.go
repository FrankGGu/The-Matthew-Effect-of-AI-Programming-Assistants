import "sort"

func runeReserve(runes []int) int {
    if len(runes) == 0 {
        return 0
    }
    sort.Ints(runes)
    maxLen := 1
    currentLen := 1
    for i := 1; i < len(runes); i++ {
        if runes[i] - runes[i-1] <= 1 {
            currentLen++
            if currentLen > maxLen {
                maxLen = currentLen
            }
        } else {
            currentLen = 1
        }
    }
    return maxLen
}