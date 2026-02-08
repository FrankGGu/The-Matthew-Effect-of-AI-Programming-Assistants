package main

func sumOfBeauty(s string) int {
    n := len(s)
    result := 0
    for i := 0; i < n; i++ {
        freq := make(map[byte]int)
        maxFreq := 0
        for j := i; j < n; j++ {
            c := s[j]
            freq[c]++
            if freq[c] > maxFreq {
                maxFreq = freq[c]
            }
            uniqueCount := 0
            for _, v := range freq {
                if v == 1 {
                    uniqueCount++
                }
            }
            result += uniqueCount
        }
    }
    return result
}