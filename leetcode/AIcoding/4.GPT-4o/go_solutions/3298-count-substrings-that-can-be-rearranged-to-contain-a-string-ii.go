func countGoodSubstrings(s string) int {
    count := 0
    n := len(s)

    for i := 0; i < n; i++ {
        freq := make(map[rune]int)
        for j := i; j < n; j++ {
            freq[rune(s[j])]++
            if isValid(freq) {
                count++
            }
        }
    }

    return count
}

func isValid(freq map[rune]int) bool {
    oddCount := 0
    for _, v := range freq {
        if v%2 != 0 {
            oddCount++
        }
    }
    return oddCount <= 1
}