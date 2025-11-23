package main

import "math"

func closestDivisors(num int) []int {
	getClosestPair := func(target int) []int {
		sqrtTarget := int(math.Sqrt(float64(target)))
		for i := sqrtTarget; i >= 1; i-- {
			if target%i == 0 {
				return []int{i, target / i}
			}
		}
		return []int{1, target} // Should not be reached for target >= 1
	}

	pair1 := getClosestPair(num + 1)
	pair2 := getClosestPair(num + 2)

	diff1 := int(math.Abs(float64(pair1[0] - pair1[1])))
	diff2 := int(math.Abs(float64(pair2[0] - pair2[1])))

	if diff1 <= diff2 {
		return pair1
	}
	return pair2
}