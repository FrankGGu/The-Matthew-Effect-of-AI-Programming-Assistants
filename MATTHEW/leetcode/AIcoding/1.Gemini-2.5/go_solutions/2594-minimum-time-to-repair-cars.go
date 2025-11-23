package main

import (
	"math"
)

func minTimeToRepairCars(ranks []int, cars int) int64 {
	var maxRank int64 = 0
	for _, r := range ranks {
		if int64(r) > maxRank {
			maxRank = int64(r)
		}
	}

	low := int64(1)
	high := maxRank * int64(cars) * int64(cars)
	ans := high

	for low <= high {
		mid := low + (high-low)/2

		totalCarsRepaired := int64(0)
		for _, r := range ranks {
			carsPerMechanic := int64(math.Sqrt(float64(mid) / float64(r)))
			totalCarsRepaired += carsPerMechanic
		}

		if totalCarsRepaired >= int64(cars) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}