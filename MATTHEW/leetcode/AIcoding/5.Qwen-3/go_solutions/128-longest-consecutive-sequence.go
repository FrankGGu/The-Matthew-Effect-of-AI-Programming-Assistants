package main

func longestConsecutive(nums []int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    longestStreak := 0

    for _, num := range nums {
        if !numSet[num-1] {
            currentNum := num
            currentStreak := 1

            for numSet[currentNum+1] {
                currentNum++
                currentStreak++
            }

            longestStreak = max(longestStreak, currentStreak)
        }
    }

    return longestStreak
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}