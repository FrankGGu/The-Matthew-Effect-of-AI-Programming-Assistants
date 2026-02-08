type CombinationIterator struct {
	characters string
	length     int
	combinationLength int
	combinations []string
	index int
}

func Constructor(characters string, combinationLength int) CombinationIterator {
	combinations := generateCombinations(characters, combinationLength)
	return CombinationIterator{
		characters: characters,
		length: len(characters),
		combinationLength: combinationLength,
		combinations: combinations,
		index: 0,
	}
}

func (this *CombinationIterator) Next() string {
	res := this.combinations[this.index]
	this.index++
	return res
}

func (this *CombinationIterator) HasNext() bool {
	return this.index < len(this.combinations)
}

func generateCombinations(characters string, combinationLength int) []string {
	var combinations []string
	var backtrack func(string, int, int)

	backtrack = func(current string, start int, k int) {
		if len(current) == combinationLength {
			combinations = append(combinations, current)
			return
		}

		for i := start; i < len(characters); i++ {
			backtrack(current + string(characters[i]), i+1, k)
		}
	}

	backtrack("", 0, combinationLength)
	return combinations
}