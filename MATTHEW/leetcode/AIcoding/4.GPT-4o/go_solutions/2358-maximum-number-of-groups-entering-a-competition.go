func maxGroups(grades []int) int {
    n := len(grades)
    groupSize := 0
    totalMembers := 0

    for {
        groupSize++
        totalMembers += groupSize
        if totalMembers > n {
            break
        }
    }

    return groupSize - 1
}