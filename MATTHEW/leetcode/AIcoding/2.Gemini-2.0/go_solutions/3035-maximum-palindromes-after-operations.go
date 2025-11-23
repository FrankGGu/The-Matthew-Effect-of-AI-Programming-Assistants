func maxPalindromesAfterOperations(words []string) int {
    freq := make(map[rune]int)
    for _, word := range words {
        for _, r := range word {
            freq[r]++
        }
    }

    oddCount := 0
    for _, count := range freq {
        if count%2 != 0 {
            oddCount++
        }
    }

    lengths := make([]int, len(words))
    for i, word := range words {
        lengths[i] = len(word)
    }
    sort.Ints(lengths)

    ans := 0
    for _, length := range lengths {
        if oddCount <= length {
            ans++
            oddCount = 0
        } else {
            oddCount -= length
        }
    }

    return ans
}

import "sort"