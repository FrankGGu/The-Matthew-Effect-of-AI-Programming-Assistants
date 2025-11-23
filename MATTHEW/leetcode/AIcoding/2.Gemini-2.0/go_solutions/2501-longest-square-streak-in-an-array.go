func longestSquareStreak(nums []int) int {
    sort.Ints(nums)
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    maxStreak := 0
    for _, num := range nums {
        currentStreak := 1
        nextNum := num * num
        for numSet[nextNum] {
            currentStreak++
            nextNum = nextNum * nextNum
        }
        if currentStreak > maxStreak {
            maxStreak = currentStreak
        }
    }

    if maxStreak > 1 {
        return maxStreak
    }
    return -1
}