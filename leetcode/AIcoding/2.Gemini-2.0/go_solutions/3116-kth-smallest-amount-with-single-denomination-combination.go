import "sort"

func kthSmallest(denominations []int, amount int, k int) int {
	combinations := []int{}
	var generateCombinations func(index int, currentSum int)
	generateCombinations = func(index int, currentSum int) {
		if currentSum > amount {
			return
		}
		if currentSum > 0 {
			combinations = append(combinations, currentSum)
		}
		if index == len(denominations) {
			return
		}
		generateCombinations(index, currentSum+denominations[index])
		generateCombinations(index+1, currentSum)
	}

	generateCombinations(0, 0)

	sort.Ints(combinations)

	uniqueCombinations := []int{}
	seen := make(map[int]bool)
	for _, num := range combinations {
		if !seen[num] {
			uniqueCombinations = append(uniqueCombinations, num)
			seen[num] = true
		}
	}

	if k > len(uniqueCombinations) {
		return -1
	}

	return uniqueCombinations[k-1]
}