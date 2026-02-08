func wordToMask(word string) int {
    mask := 0
    for _, r := range word {
        mask |= (1 << (r - 'a'))
    }
    return mask
}

func countWords(startWords []string, targetWords []string) int {
    startWordMasks := make(map[int]bool)
    for _, word := range startWords {
        startWordMasks[wordToMask(word)] = true
    }

    count := 0
    for _, targetWord := range targetWords {
        targetMask := wordToMask(targetWord)

        for i := 0; i < 26; i++ {
            charBit := (1 << i)
            if (targetMask & charBit) != 0 { 
                potentialStartMask := targetMask ^ charBit
                if startWordMasks[potentialStartMask] {
                    count++
                    break 
                }
            }
        }
    }
    return count
}