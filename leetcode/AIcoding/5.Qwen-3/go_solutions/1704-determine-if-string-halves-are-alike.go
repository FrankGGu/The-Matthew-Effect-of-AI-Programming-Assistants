package main

func halvesAreAlike(s string) bool {
    vowels := map[rune]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true, 'A': true, 'E': true, 'I': true, 'O': true, 'U': true}
    n := len(s)
    a, b := 0, 0
    for i := 0; i < n/2; i++ {
        if vowels[rune(s[i])] {
            a++
        }
    }
    for i := n / 2; i < n; i++ {
        if vowels[rune(s[i])] {
            b++
        }
    }
    return a == b
}