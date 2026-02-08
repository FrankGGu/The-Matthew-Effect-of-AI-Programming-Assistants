package main

func maxCharSubstrings(s string, k int) int {
    n := len(s)
    maxLen := 0
    for i := 0; i < n; i++ {
        count := make(map[byte]int)
        left := i
        for right := i; right < n; right++ {
            count[s[right]]++
            if count[s[right]] == k {
                currentLen := right - left + 1
                if currentLen > maxLen {
                    maxLen = currentLen
                }
            } else if count[s[right]] > k {
                for count[s[right]] > k {
                    count[s[left]]--
                    left++
                }
            }
        }
    }
    return maxLen
}