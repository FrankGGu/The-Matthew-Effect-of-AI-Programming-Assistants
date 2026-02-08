package main

import (
	"sort"
)

type Pile struct {
	aliceVal int
	bobVal   int
	sumVal   int
}

func stoneGameVI(aliceValues []int, bobValues []int) int {
	n := len(aliceValues)
	piles := make([]Pile, n)
	for i := 0; i < n; i++ {
		piles[i] = Pile{
			aliceVal: aliceValues[i],
			bobVal:   bobValues[i],
			sumVal:   aliceValues[i] + bobValues[i],
		}
	}

	sort.Slice(piles, func(i, j int) bool {
		return piles[i].sumVal > piles[j].sumVal
	})

	aliceScore := 0
	bobScore := 0

	for i := 0; i < n; i++ {
		if i%2 == 0 { // Alice's turn
			aliceScore += piles[i].aliceVal
		} else { // Bob's turn
			bobScore += piles[i].bobVal
		}
	}

	return aliceScore - bobScore
}