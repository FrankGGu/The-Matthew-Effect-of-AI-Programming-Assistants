package main

func countOfSubstrings(s string, k int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    count := 0
    n := len(s)
    for i := 0; i < n; i++ {
        vowelCount := make(map[byte]int)
        consonantCount := 0
        for j := i; j < n; j++ {
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