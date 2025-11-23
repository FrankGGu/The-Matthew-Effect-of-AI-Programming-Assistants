func findWinners(matches [][]int) [][]int {
    losses := make(map[int]int)
    players := make(map[int]bool)

    for _, match := range matches {
        winner := match[0]
        loser := match[1]

        players[winner] = true
        players[loser] = true

        losses[loser]++
    }

    winners := []int{}
    losers := []int{}

    for player := range players {
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

import "sort"