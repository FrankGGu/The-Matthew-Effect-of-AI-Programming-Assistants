package main

func findNumOfValidWords(words []string, puzzles []string) []int {
    // wordMaskCounts stores the frequency of each unique bitmask representing a word.
    // Key: bitmask of a word
    // Value: count of words having that bitmask
    wordMaskCounts := make(map[int]int)

    // Pre-process all words to calculate their bitmasks and store their counts.
    for _, word := range words {
        mask := 0
        for _, char := range word {
            mask |= (1 << (char - 'a'))
        }
        wordMaskCounts[mask]++
    }

    // Initialize the result array for puzzles.
    ans := make([]int, len(puzzles))

    // Iterate through each puzzle to find the number of valid words.
    for i, puzzle := range puzzles {
        // The first character of the puzzle must be present in a valid word.
        // Create a bitmask for this first character.
        firstCharMask := (1 << (puzzle[0] - 'a'))

        // Create a bitmask for the entire puzzle.
        // This mask represents all unique characters present in the puzzle.
        puzzleMask := 0
        for _, char := range puzzle {
            puzzleMask |= (1 << (char - 'a'))
        }

        currentPuzzleValidWords := 0

        // Iterate through all possible submasks of the puzzleMask.
        // Each submask represents a potential set of characters for a valid word.
        // The loop `for submask := puzzleMask; submask > 0; submask = (submask - 1) & puzzleMask`
        // efficiently generates all subsets of `puzzleMask`.
        for submask := puzzleMask; submask > 0; submask = (submask - 1) & puzzleMask {
            // Condition 1: The word must contain the first letter of the puzzle.
            // This means the submask (representing the word's characters) must have the bit set for the first character.
            if (submask & firstCharMask) != 0 {
                // Condition 2: Every letter in the word must be in the puzzle.
                // This condition is implicitly satisfied because 'submask' is a subset (submask) of 'puzzleMask'.
                // If there are words whose character set matches this 'submask', add their count to the total.
                if count, ok := wordMaskCounts[submask]; ok {
                    currentPuzzleValidWords += count
                }
            }
        }
        ans[i] = currentPuzzleValidWords
    }

    return ans
}