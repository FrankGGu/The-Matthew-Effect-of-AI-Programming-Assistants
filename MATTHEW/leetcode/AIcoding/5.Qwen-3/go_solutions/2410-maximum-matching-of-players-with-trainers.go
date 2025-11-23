package main

func matchPlayersToTrainers(players []int, trainers []int) int {
    sort.Ints(players)
    sort.Ints(trainers)
    i, j := 0, 0
    count := 0
    for i < len(players) && j < len(trainers) {
        if players[i] <= trainers[j] {
            count++
            i++
            j++
        } else {
            j++
        }
    }
    return count
}