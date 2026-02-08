package main

func rearrangeCharacters(s string, target string) int {
    countS := make(map[rune]int)
    countTarget := make(map[rune]int)

    for _, c := range s {
        countS[c]++
    }

    for _, c := range target {
        countTarget[c]++
    }

    minFreq := 1000000
    for c, freq := range countTarget {
        if countS[c] < freq {
            return 0
        }
        minFreq = min(minFreq, countS[c]/freq)
    }

    return minFreq
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}