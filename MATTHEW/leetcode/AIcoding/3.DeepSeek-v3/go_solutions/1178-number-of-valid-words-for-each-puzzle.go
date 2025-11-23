func findNumOfValidWords(words []string, puzzles []string) []int {
    wordMasks := make(map[int]int)
    for _, word := range words {
        mask := 0
        for _, c := range word {
            mask |= 1 << (c - 'a')
        }
        wordMasks[mask]++
    }

    result := make([]int, len(puzzles))
    for i, puzzle := range puzzles {
        puzzleMask := 0
        firstChar := 1 << (puzzle[0] - 'a')
        for _, c := range puzzle {
            puzzleMask |= 1 << (c - 'a')
        }

        count := 0
        subset := puzzleMask
        for {
            if (subset & firstChar) == firstChar {
                count += wordMasks[subset]
            }
            if subset == 0 {
                break
            }
            subset = (subset - 1) & puzzleMask
        }
        result[i] = count
    }
    return result
}