func characterReplacement(s string, k int) int {
    counts := make([]int, 26) // Frequency map for characters 'A' through 'Z'
    left := 0                 // Left pointer of the sliding window
    maxFreq := 0              // Maximum frequency of any character in the current window
    maxLength :=