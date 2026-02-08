package main

func findingUsersActiveMinutes(logs [][]int, k int) []int {
    userMap := make(map[int]map[int]bool)
    for _, log := range logs {
        userId, time := log[0], log[1]
        if _, exists := userMap[userId]; !exists {
            userMap[userId] = make(map[int]bool)
        }
        userMap[userId][time] = true
    }

    result := make([]int, k)
    for _, times := range userMap {
        count := len(times)
        if count <= k {
            result[count-1]++
        }
    }

    return result
}