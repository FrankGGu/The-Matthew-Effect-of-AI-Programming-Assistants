package main

func findWinners(matches [][]int) [][]int {
    lossCount := make(map[int]int)
    players := make(map[int]bool)

    for _, match := range matches {
        winner := match[0]
        loser := match[1]

        players[winner] = true
        players[loser] = true

        lossCount[loser]++
    }

    zeroLoss := []int{}
    oneLoss := []int{}

    for player := range players {
        if lossCount[player] == 0 {
            zeroLoss = append(zeroLoss, player)
        } else if lossCount[player] == 1 {
            oneLoss = append(oneLoss, player)
        }
    }

    sort.Ints(zeroLoss)
    sort.Ints(oneLoss)

    return [][]int{zeroLoss, oneLoss}
}