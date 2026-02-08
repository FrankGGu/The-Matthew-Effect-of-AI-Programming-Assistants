func findNumOfValidWords(words []string, puzzles []string) []int {
    wordCount := make(map[int]int)

    for _, word := range words {
        bitmask := 0
        for _, ch := range word {
            bitmask |= 1 << (ch - 'a')
        }
        wordCount[bitmask]++
    }

    result := make([]int, len(puzzles))

    for i, puzzle := range puzzles {
        firstChar := 1 << (puzzle[0] - 'a')
        for mask := 0; mask < (1 << 7); mask++ {
            if mask&firstChar != 0 {
                count := 0
                for wordMask, cnt := range wordCount {
                    if (mask & wordMask) == wordMask {
                        count += cnt
                    }
                }
                result[i] += count
            }
        }
    }

    return result
}