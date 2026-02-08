package main

import "math"

func minCost(num1 string, num2 string, cost int) int {
	totalCost := 0
	n := len(num1)

	for i := 0; i < n; i++ {
		d1 := int(num1[i] - '0')
		d2 := int(num2[i] - '0')

		diff := int(math.Abs(float64(d1 - d2)))

		// The minimum steps to change digit d1 to d2 on a 0-9 dial
		// is the minimum of going directly (diff) or going the other way around (10 - diff).
		costPerDigit := int(math.Min(float64(diff), float64(10-diff))) * cost
		totalCost += costPerDigit
	}

	return totalCost
}