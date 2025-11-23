package main

func countVowelSubstrings(s string) int {
    count := 0
    vowels := map[rune]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    n := len(s)
    for i := 0; i < n; i++ {
        if !vowels[rune(s[i])] {
            continue
        }
        a, e, i, o, u := 0, 0, 0, 0, 0
        for j := i; j < n; j++ {
            c := rune(s[j])
            if !vowels[c] {
                break
            }
            if c == 'a' {
                a++
            } else if c == 'e' {
                e++
            } else if c == 'i' {
                i++
            } else if c == 'o' {
                o++
            } else if c == 'u' {
                u++
            }
            if a > 0 && e > 0 && i > 0 && o > 0 && u > 0 {
                count++
            }
        }
    }
    return count
}