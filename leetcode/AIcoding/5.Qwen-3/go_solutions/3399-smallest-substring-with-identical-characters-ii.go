package main

func minimumSubstring(s string) int {
    n := len(s)
    minLen := n + 1
    count := make(map[byte]int)
    left := 0

    for right := 0; right < n; right++ {
        count[s[right]]++
        for len(count) == 2 {
            if right-left+1 < minLen {
                minLen = right - left + 1
            }
            count[s[left]]--
            if count[s[left]] == 0 {
                delete(count, s[left])
            }
            left++
        }
    }

    if minLen > n {
        return -1
    }
    return minLen
}