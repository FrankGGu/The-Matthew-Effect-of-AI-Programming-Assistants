package main

func rabbitsInForest(answers []int) int {
	counts := make(map[int]int)
	for _, answer := range answers {
		counts[answer]++
	}

	totalRabbits := 0
	for answer, count := range counts {
		// If a rabbit answers 'x', it means there are 'x' other rabbits of the same color.
		// So, including itself, there are 'x + 1' rabbits of that color.
		// All 'x + 1' rabbits of the same color will give the same answer 'x'.
		// We have 'count' rabbits that reported 'x'.
		// The number of groups of 'x + 1' rabbits needed to account for 'count' reports
		// is ceil(count / (x + 1)).
		// Using integer division, ceil(a / b) can be calculated as (a + b - 1) / b.
		// Here, a = count, b = x + 1.
		// So, numGroups = (count + (x + 1) - 1) / (x + 1) which simplifies to (count + x) / (x + 1).
		numGroups := (count + answer) / (answer + 1)
		totalRabbits += numGroups * (answer + 1)
	}

	return totalRabbits
}