package main

import (
	"math"
	"sort"
)

func maximumEnergyBoost(drinks [][]int) int {
	n := len(drinks)
	if n == 0 {
		return 0
	}

	maxEnergyOverall := 0

	sort.Slice(drinks, func(i, j int) bool {
		return drinks[i][1] < drinks[j][1]
	})

	maxAPrefix := math.MinInt64

	for i := 0; i < n; i++ {
		e_i, c_i := drinks[i][0], drinks[i][1]

		if e_i > maxEnergyOverall {
			maxEnergyOverall = e_i
		}

		if maxAPrefix != math.MinInt64 {
			currentTwoDrinkBoost := maxAPrefix + (e_i - c_i)
			if currentTwoDrinkBoost > maxEnergyOverall {
				maxEnergyOverall = currentTwoDrinkBoost
			}
		}

		currentA := e_i + c_i
		if currentA > maxAPrefix {
			maxAPrefix = currentA
		}
	}

	maxBSuffix := math.MinInt64

	for i := n - 1; i >= 0; i-- {
		e_i, c_i := drinks[i][0], drinks[i][1]

		if maxBSuffix != math.MinInt64 {
			currentTwoDrinkBoost := (e_i + c_i) + maxBSuffix
			if currentTwoDrinkBoost > maxEnergyOverall {
				maxEnergyOverall = currentTwoDrinkBoost
			}
		}

		currentB := e_i - c_i
		if currentB > maxBSuffix {
			maxBSuffix = currentB
		}
	}

	return maxEnergyOverall
}