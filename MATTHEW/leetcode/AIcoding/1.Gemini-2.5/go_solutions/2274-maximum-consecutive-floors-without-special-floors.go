import (
	"sort"
)

func maximumConsecutive(bottom int, top int, special []int) int {
	sort.Ints(special)

	maxConsecutive := 0

	// Calculate consecutive floors from 'bottom' to 'special[0]-1'
	// The number of non-special floors is special[0] - bottom
	maxConsecutive = special[0] - bottom

	// Calculate consecutive floors between adjacent special floors
	// For special[i] and special[i+1], the non-special floors are from special[i]+1 to special[i+1]-1
	// The count is (special[i+1]-1) - (special[i]+1) + 1 = special[i+1] - special[i] - 1
	for i := 0; i < len(special)-1; i++ {
		currentConsecutive := special[i+1] - special[i] - 1
		if currentConsecutive > maxConsecutive {
			maxConsecutive = currentConsecutive
		}
	}

	// Calculate consecutive floors from 'special[len(special)-1]+1' to 'top'
	// The number of non-special floors is top - special[len(special)-1]
	currentConsecutive := top - special[len(special)-1]
	if currentConsecutive > maxConsecutive {
		maxConsecutive = currentConsecutive
	}

	return maxConsecutive
}