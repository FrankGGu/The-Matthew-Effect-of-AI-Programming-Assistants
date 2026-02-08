package main

func wordSubsets(words1 []string, words2 []string) []string {
    maxFreq := make([]int, 26)
    for _, word := range words2 {
        freq := make([]int, 26)
        for _, c := range word {
            freq[c-'a']++
        }
        for i := 0; i < 26; i++ {
            if freq[i] > maxFreq[i] {
                maxFreq[i] = freq[i]
            }
        }
    }

    result := []string{}
    for _, word := range words1 {
        freq := make([]int, 26)
        for _, c := range word {
            freq[c-'a']++
        }
        match := true
        for i := 0; i < 26; i++ {
            if freq[i] < maxFreq[i] {
                match = false
                break
            }
        }
        if match {
            result = append(result, word)
        }
    }
    return result
}