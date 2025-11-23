package main

func maximumLengthSubstring(s string) int {
    freq := make(map[byte]int)
    left := 0
    maxLength := 0
    for right := 0; right < len(s); right++ {
        freq[s[right]]++
        for freq[s[right]] > 2 {
            freq[s[left]]--
            left++
        }
        if right - left + 1 > maxLength {
            maxLength = right - left + 1
        }
    }
    return maxLength
}