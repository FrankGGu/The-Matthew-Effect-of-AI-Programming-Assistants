package main

import "math"

func maximizeTheAmount(initialAmount []int, conversionRate1 []int, conversionRate2 []int, discount int) int64 {
	n := len(initialAmount)

	// Scenario 1: At least one item is converted on Day 1.
	// In this scenario, the 'discount' is never applied.
	// For each item i, we choose the maximum of three options:
	// 1. Convert on Day 1: initialAmount[i] * conversionRate1[i]
	// 2. Convert on Day 2: initialAmount[i] * conversionRate2[i]
	// 3. Do not convert: 0
	var sum1 int64
	for i := 0; i < n; i++ {
		val1 := int64(initialAmount[i]) * int64(conversionRate1[i])
		val2 := int64(initialAmount[i]) * int64(conversionRate2[i])

		// Take the maximum profit for this item, or 0 if both conversions yield negative profit.
		currentMaxProfit := int64(0)
		currentMaxProfit = int64(math.Max(float64(currentMaxProfit), float64(val1)))
		currentMaxProfit = int64(math.Max(float64(currentMaxProfit), float64(val2)))
		sum1 += currentMaxProfit
	}

	// Scenario 2: No items are converted on Day 1.
	// In this scenario, the 'discount' is applied to every item converted on Day 2.
	// For each item i, we choose the maximum of two options:
	// 1. Convert on Day 2: initialAmount[i] * conversionRate2[i] + discount
	//    (Conversion on Day 1 is explicitly excluded in this scenario)
	// 2. Do not convert: 0
	var sum2 int64
	for i := 0; i < n; i++ {
		val2WithDiscount := int64(initialAmount[i]) * int64(conversionRate2[i]) + int64(discount)

		// Take the maximum profit for this item, or 0 if conversion yields negative profit.
		currentMaxProfit := int64(0)
		currentMaxProfit = int64(math.Max(float64(currentMaxProfit), float64(val2WithDiscount)))
		sum2 += currentMaxProfit
	}

	// The final answer is the maximum total amount obtained from these two scenarios.
	return int64(math.Max(float64(sum1), float64(sum2)))
}