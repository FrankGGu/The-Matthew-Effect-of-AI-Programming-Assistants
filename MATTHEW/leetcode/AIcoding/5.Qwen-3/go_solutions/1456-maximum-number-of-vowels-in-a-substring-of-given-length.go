package main

func maxVowels(s string, k int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    maxCount := 0
    currentCount := 0

    for i := 0; i < len(s); i++ {
        if vowels[s[i]] {
            currentCount++
        }

        if i >= k {
            if vowels[s[i-k]] {
                currentCount--
            }
        }

        if i >= k-1 {
            if currentCount > maxCount {
                maxCount = currentCount
            }
        }
    }

    return maxCount
}