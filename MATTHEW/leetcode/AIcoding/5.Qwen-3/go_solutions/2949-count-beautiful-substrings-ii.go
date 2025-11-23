package main

func countBeautifulSubstrings(s string) int {
    n := len(s)
    count := 0
    vowels := map[rune]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    for i := 0; i < n; i++ {
        vowelCount := 0
        for j := i; j < n; j++ {
            if vowels[rune(s[j])] {
                vowelCount++
            }
            if (j-i+1)%2 == 0 && vowelCount == (j-i+1)/2 {
                count++
            }
        }
    }
    return count
}