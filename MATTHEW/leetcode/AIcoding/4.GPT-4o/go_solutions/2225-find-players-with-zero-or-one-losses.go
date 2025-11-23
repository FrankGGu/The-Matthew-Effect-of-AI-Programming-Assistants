package main

func findWinners(matches [][]int) [][]int {
    winMap := make(map[int]int)
    lossMap := make(map[int]int)

    for _, match := range matches {
        winner, loser := match[0], match[1]
        winMap[winner]++
        if _, found := winMap[loser]; !found {
            winMap[loser] = 0
        }
        lossMap[loser]++
    }

    zeroLoss := []int{}
    oneLoss := []int{}

    for player := range winMap {
        if lossMap[player] == 0 {
            zeroLoss = append(zeroLoss, player)
        } else if lossMap[player] == 1 {
            oneLoss = append(oneLoss, player)
        }
    }

    sort.Ints(zeroLoss)
    sort.Ints(oneLoss)

    return [][]int{zeroLoss, oneLoss}
}