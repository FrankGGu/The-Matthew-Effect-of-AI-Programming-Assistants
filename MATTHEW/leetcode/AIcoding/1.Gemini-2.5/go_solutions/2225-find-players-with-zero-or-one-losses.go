package main

import (
	"sort"
)

func findWinners(matches [][]int) [][]int {
	losses := make(map[int]int)
	allPlayers := make(map[int]bool)

	for _, match := range matches {
		winner := match[0]
		loser := match[1]

		losses[loser]++
		allPlayers[winner] = true
		allPlayers[loser] = true
	}

	var zeroLosses []int
	var oneLoss []int

	for player := range allPlayers {
		lossCount := losses[player]
		if lossCount == 0 {
			zeroLosses = append(zeroLosses, player)
		} else if lossCount == 1 {
			oneLoss = append(oneLoss, player)
		}
	}

	sort.Ints(zeroLosses)
	sort.Ints(oneLoss)

	return [][]int{zeroLosses, oneLoss}
}