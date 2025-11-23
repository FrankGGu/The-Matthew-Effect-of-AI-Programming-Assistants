func findingUsersActiveMinutes(logs [][]int, k int) []int {
    userMap := make(map[int]map[int]struct{})
    for _, log := range logs {
        user, minute := log[0], log[1]
        if userMap[user] == nil {
            userMap[user] = make(map[int]struct{})
        }
        userMap[user][minute] = struct{}{}
    }

    result := make([]int, k)
    for _, minutes := range userMap {
        result[len(minutes)-1]++
    }

    return result
}