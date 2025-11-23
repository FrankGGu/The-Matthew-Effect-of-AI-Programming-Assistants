package main

import (
	"sort"
)

func successfulPairs(spells []int, potions []int, success int64) []int {
	n := len(spells)
	m := len(potions)
	results := make([]int, n)
	sort.Ints(potions)

	for i, spell := range spells {
		target := success / int64(spell)
		if success%int64(spell) != 0 {
			target++
		}
		left := sort.Search(m, func(j int) bool {
			return int64(potions[j]) >= target
		})
		results[i] = m - left
	}
	return results
}