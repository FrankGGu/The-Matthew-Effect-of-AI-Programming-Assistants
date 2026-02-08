func findingUsersActiveMinutes(logs [][]int, k int) []int {
    userMap := make(map[int]map[int]bool)
    for _, log := range logs {
        id, time := log[0], log[1]
        if _, ok := userMap[id]; !ok {
            userMap[id] = make(map[int]bool)
        }
        userMap[id][time] = true
    }

    result := make([]int, k)
    for _, times := range userMap {
        uam := len(times)
        if uam > 0 && uam <= k {
            result[uam-1]++
        }
    }
    return result
}