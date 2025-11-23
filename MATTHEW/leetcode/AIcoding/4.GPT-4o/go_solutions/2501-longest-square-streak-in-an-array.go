import "sort"

func longestSquareStreak(arr []int) int {
    sort.Ints(arr)
    numSet := make(map[int]bool)
    for _, num := range arr {
        numSet[num] = true
    }

    maxStreak := 0

    for _, num := range arr {
        streak := 0
        current := num

        for numSet[current] {
            streak++
            current++
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