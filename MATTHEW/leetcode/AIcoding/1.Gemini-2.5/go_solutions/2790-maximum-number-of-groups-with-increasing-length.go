import (
	"sort"
)

func maxIncreasingGroups(usageLimits []int) int {
	sort.Ints(usageLimits)

	var totalItemsAvailable int64 = 0
	numGroupsPossible := 0

	for _, limit := range usageLimits {
		totalItemsAvailable += int64(limit)

		// Calculate the required items for numGroupsPossible + 1 groups.
		// If we can currently form 'k' groups (numGroupsPossible),
		// we check if we can form 'k+1' groups.
		// The number of items needed for groups of lengths 1, 2, ..., (k+1) is (k+1)*(k+2)/2.
		// Use int64 for calculation to prevent overflow.
		requiredItemsForNextGroup := int64(numGroupsPossible+1) * int64(numGroupsPossible+2) / 2

		if totalItemsAvailable >= requiredItemsForNextGroup {
			numGroupsPossible++
		}
	}

	return numGroupsPossible
}