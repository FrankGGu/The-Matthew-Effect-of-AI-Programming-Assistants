func countUnhappyFriends(n int, preferences [][]int, pairs [][]int) int {
    partner := make([]int, n)
    unhappyCount := 0

    for _, pair := range pairs {
        partner[pair[0]] = pair[1]
        partner[pair[1]] = pair[0]
    }

    for i := 0; i < n; i++ {
        for _, friend := range preferences[i] {
            if friend == partner[i] {
                break
            }
            if indexOf(preferences[friend], i) < indexOf(preferences[friend], partner[friend]) {
                unhappyCount++
                break
            }
        }
    }

    return unhappyCount
}

func indexOf(arr []int, target int) int {
    for i, v := range arr {
        if v == target {
            return i
        }
    }
    return -1
}