func findWinners(matches [][]int) [][]int {
    losses := make(map[int]int)
    allPlayers := make(map[int]bool)

    for _, match := range matches {
        winner := match[0]
        loser := match[1]

        allPlayers[winner] = true
        allPlayers[loser] = true

        losses[loser]++
    }

    winners := []int{}
    losers := []int{}

    for player := range allPlayers {
        if _, ok := losses[player]; !ok {
            winners = append(winners, player)
        } else if losses[player] == 1 {
            losers = append(losers, player)
        }
    }

    sort.Ints(winners)
    sort.Ints(losers)

    return [][]int{winners, losers}
}