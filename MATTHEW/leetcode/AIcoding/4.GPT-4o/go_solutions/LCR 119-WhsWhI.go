func longestConsecutive(nums []int) int {
    numSet := make(map[int]struct{})
    for _, num := range nums {
        numSet[num] = struct{}{}
    }

    longestStreak := 0

    for num := range numSet {
        if _, found := numSet[num-1]; !found {
            currentNum := num
            currentStreak := 1

            for _, found := numSet[currentNum+1]; found; {
                currentNum++
                currentStreak++
                _, found = numSet[currentNum+1]
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