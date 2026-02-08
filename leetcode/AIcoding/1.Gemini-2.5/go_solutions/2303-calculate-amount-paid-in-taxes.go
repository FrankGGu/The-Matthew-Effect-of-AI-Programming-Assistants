package main

import "math"

func calculateTax(brackets [][]int, income int) float64 {
	totalTax := 0.0
	prevUpper := 0

	for _, bracket := range brackets {
		currentUpper := bracket[0]
		percent := bracket[1]

		// Calculate the taxable amount within the current bracket's range.
		// This is limited by the actual income remaining to be taxed
		// and the upper bound of the current bracket.

		taxableAmountInCurrentBracket := 0
		if income > prevUpper {
			// The amount of income that falls into this bracket's range.
			// It's the minimum of:
			// 1. The income remaining that could be taxed in this bracket (income - prevUpper)
			// 2. The full range of this bracket (currentUpper - prevUpper)
			amountToTax := int(math.Min(float64(income-prevUpper), float64(currentUpper-prevUpper)))

			taxableAmountInCurrentBracket = amountToTax
			totalTax += float64(taxableAmountInCurrentBracket) * float64(percent) / 100.0
		}

		prevUpper = currentUpper

		// If the income has been fully accounted for (i.e., income is less than or equal to
		// the upper limit of the current bracket), no further tax needs to be calculated.
		if income <= prevUpper {
			break
		}
	}

	return totalTax
}