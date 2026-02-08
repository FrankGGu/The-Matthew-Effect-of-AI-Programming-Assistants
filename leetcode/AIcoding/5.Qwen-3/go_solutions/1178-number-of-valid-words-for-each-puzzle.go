package main

func findNumOfValidWords(words []string, puzzles []string) []int {
    wordCount := make(map[int]int)
    for _, word := range words {
        mask := 0
        for _, c := range word {
            mask |= 1 << (c - 'a')
        }
        wordCount[mask]++
    }

    result := make([]int, len(puzzles))
    for i, puzzle := range puzzles {
        count := 0
        mask := 0
        for _, c := range puzzle {
            mask |= 1 << (c - 'a')
        }
        current := mask
        for {
            count += wordCount[current]
            if current == 0 {
                break
            }
            current = (current - 1) & mask
        }
        result[i] = count
    }
    return result
}