func longestSquareStreak(nums []int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    maxStreak := 0
    for num := range numSet {
        current := num
        streak := 1
        for {
            next := current * current
            if !numSet[next] {
                break
            }
            streak++
            current = next
        }
        if streak > maxStreak {
            maxStreak = streak
        }
    }

    if maxStreak < 2 {
        return -1
    }
    return maxStreak
}