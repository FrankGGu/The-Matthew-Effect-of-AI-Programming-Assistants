package main

import (
	"sort"
)

func fillCups(amount []int) int {
	sort.Ints(amount)

	a := amount[0]
	b := amount[1]
	c := amount[2]

	sum := a + b + c

	// The minimum time is either the count of the largest type of cup,
	// or half of the total sum of cups (rounded up), whichever is greater.
	//
	// Case 1: The largest cup count (c) is greater than the sum of the other two (a + b).
	// In this scenario, we will always be able to pair up the 'a' and 'b' cups with 'c' cups.
	// After 'a + b' seconds, all 'a' and 'b' cups will be filled, and 'c' will be reduced to 'c - (a + b)'.
	// The remaining 'c - (a + b)' cups must then be filled one by one.
	// Total time = (a + b) + (c - (a + b)) = c.
	//
	// Case 2: The largest cup count (c) is less than or equal to the sum of the other two (a + b).
	// In this scenario, we can always find two different types of cups to fill in each second
	// until at most one cup remains. This means we are reducing the total number of cups by 2
	// in almost every second.
	// The total time will be ceil(sum / 2), which can be calculated as (sum + 1) / 2 using integer division.
	//
	// Combining both cases, the minimum time is max(c, (sum + 1) / 2).
	// If c > a + b, then c is the answer. In this situation, sum < 2c, so (sum + 1) / 2 <= c.
	// Thus, max(c, (sum + 1) / 2) will correctly yield c.
	// If c <= a + b, then (sum + 1) / 2 is the answer. In this situation, sum >= 2c, so (sum + 1) / 2 >= c.
	// Thus, max(c, (sum + 1) / 2) will correctly yield (sum + 1) / 2.

	return max(c, (sum+1)/2)
}

func max(x, y int) int {
	if x > y {
		return x
	}
	return y
}