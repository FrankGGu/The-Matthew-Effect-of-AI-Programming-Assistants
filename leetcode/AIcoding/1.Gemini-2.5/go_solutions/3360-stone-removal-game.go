package main

import (
	"sort"
)

type Pile struct {
	aliceVal int
	bobVal   int
	sumVal   int
}

type Piles []Pile

func (p Piles) Len() int {
	return len(p)
}

func (p Piles) Less(i, j int) bool {
	return p[i].sumVal > p[j].sumVal
}

func (p Piles) Swap(i, j int) {
	p[i], p[j] = p[j], p[i]
}

func stoneGameVI(aliceValues []int, bobValues []int) int {
	n := len(aliceValues)
	piles := make(Piles, n)

	for i := 0; i < n; i++ {
		piles[i] = Pile{
			aliceVal: aliceValues[i],
			bobVal:   bobValues[i],
			sumVal:   aliceValues[i] + bobValues[i],
		}
	}

	sort.Sort(piles)

	aliceScore := 0
	bobScore := 0

	for i := 0; i < n; i++ {
		if i%2 == 0 {
			aliceScore += piles[i].aliceVal
		} else {
			bobScore += piles[i].bobVal
		}
	}

	if aliceScore > bobScore {
		return 1
	} else if aliceScore < bobScore {
		return -1
	} else {
		return 0
	}
}