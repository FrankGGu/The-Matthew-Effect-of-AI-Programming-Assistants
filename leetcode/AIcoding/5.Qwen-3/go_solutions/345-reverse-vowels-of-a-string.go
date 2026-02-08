package main

func reverseVowels(s string) string {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true, 'A': true, 'E': true, 'I': true, 'O': true, 'U': true}
    runes := []rune(s)
    left, right := 0, len(runes)-1
    for left < right {
        for left < right && !vowels[runes[left]] {
            left++
        }
        for left < right && !vowels[runes[right]] {
            right--
        }
        if left < right {
            runes[left], runes[right] = runes[right], runes[left]
            left++
            right--
        }
    }
    return string(runes)
}