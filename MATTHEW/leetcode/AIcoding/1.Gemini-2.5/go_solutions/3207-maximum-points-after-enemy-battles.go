package main

import (
	"sort"
)

func maximumPoints(enemy []int, initialEnergy int) int {
	sort.Ints(enemy)

	currentEnergy := int64(initialEnergy)
	currentPoints := 0
	maxPoints := 0

	left := 0
	right := len(enemy) - 1

	for left <= right {
		if currentEnergy >= int64(enemy[left]) {
			// Option 1: Defeat the weakest enemy to gain a point
			currentEnergy -= int64(enemy[left])
			currentPoints++
			left++
			if currentPoints > maxPoints {
				maxPoints = currentPoints
			}
		} else if currentPoints >= 1 {
			// Option 2: Sacrifice a point to gain energy from the strongest enemy
			currentEnergy += int64(enemy[right])
			currentPoints--
			right--
		} else {
			// Cannot defeat the weakest enemy and cannot gain energy
			break
		}
	}

	return maxPoints
}