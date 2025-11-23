func maxPlayers(trainers []int, players []int) int {
    sort.Ints(trainers)
    sort.Ints(players)

    i, j := 0, 0
    count := 0

    for i < len(trainers) && j < len(players) {
        if trainers[i] >= players[j] {
            count++
            j++
        }
        i++
    }

    return count
}