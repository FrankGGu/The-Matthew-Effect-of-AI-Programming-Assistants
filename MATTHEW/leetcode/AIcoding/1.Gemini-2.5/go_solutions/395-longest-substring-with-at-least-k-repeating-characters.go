func longestSubstring(s string, k int) int {
    n := len(s)
    if n == 0 || n < k {
        return 0
    }

    freq := make(map[rune]int)
    for _, char := range s {
        freq[char]++
    }

    badCharExists :=