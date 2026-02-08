import "strings"

type CombinationIterator struct {
	chars        []rune
	k            int
	indices      []int
	hasNextValue bool
}

func Constructor(characters string, combinationLength int) CombinationIterator {
	ci := CombinationIterator{
		chars:        []rune(characters),
		k:            combinationLength,
		indices:      make([]int, combinationLength),
		hasNextValue: true,
	}

	for i := 0; i < combinationLength; i++ {
		ci.indices[i] = i
	}

	return ci
}

func (this *CombinationIterator) Next() string {
	if !this.hasNextValue {
		return ""
	}

	var sb strings.Builder
	sb.Grow(this.k)
	for _, idx := range this.indices {
		sb.WriteRune(this.chars[idx])
	}
	result := sb.String()

	i := this.k - 1
	for i >= 0 && this.indices[i] == len(this.chars)-(this.k-i) {
		i--
	}

	if i < 0 {
		this.hasNextValue = false
	} else {
		this.indices[i]++
		for j := i + 1; j < this.k; j++ {
			this.indices[j] = this.indices[j-1] + 1
		}
	}

	return result
}

func (this *CombinationIterator) HasNext() bool {
	return this.hasNextValue
}