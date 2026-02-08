package main

func countOfSubstrings(s string, k int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    count := 0
    for i := 0; i < len(s); i++ {
        vowelCount := make(map[byte]int)
        consonantCount := 0
        for j := i; j < len(s); j++ {
            if vowels[s[j]] {
                vowelCount[s[j]]++
            } else {
                consonantCount++
            }
            if consonantCount == k && len(vowelCount) == 5 {
                count++
            }
        }
    }
    return count
}