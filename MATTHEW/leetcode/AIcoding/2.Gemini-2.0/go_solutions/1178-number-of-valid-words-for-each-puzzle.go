func findNumOfValidWords(words []string, puzzles []string) []int {
	wordFreq := make(map[int]int)
	for _, word := range words {
		mask := 0
		for _, c := range word {
			mask |= 1 << (c - 'a')
		}
		if bits.OnesCount(uint(mask)) <= 7 {
			wordFreq[mask]++
		}
	}

	result := make([]int, len(puzzles))
	for i, puzzle := range puzzles {
		firstCharMask := 1 << (puzzle[0] - 'a')
		count := 0
		mask := 0
		for _, c := range puzzle {
			mask |= 1 << (c - 'a')
		}

		for submask := mask; submask > 0; submask = (submask - 1) & mask {
			if (submask & firstCharMask) != 0 {
				count += wordFreq[submask]
			}
		}
		result[i] = count
	}

	return result
}

import "math/bits"