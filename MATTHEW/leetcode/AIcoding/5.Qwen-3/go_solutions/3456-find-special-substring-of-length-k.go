package main

func numberOfSpecialSubstrings(s string, k int) int {
    count := 0
    freq := make(map[rune]int)
    left := 0

    for right, char := range s {
        freq[char]++

        for len(freq) > k {
            leftChar := rune(s[left])
            freq[leftChar]--
            if freq[leftChar] == 0 {
                delete(freq, leftChar)
            }
            left++
        }

        if len(freq) == k {
            count++
        }
    }

    return count
}