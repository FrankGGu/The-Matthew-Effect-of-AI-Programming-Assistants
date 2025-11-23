package main

func checkIfPangram(sentence string) bool {
    seen := make(map[rune]bool)
    for _, c := range sentence {
        if c >= 'a' && c <= 'z' {
            seen[c] = true
        }
    }
    return len(seen) == 26
}