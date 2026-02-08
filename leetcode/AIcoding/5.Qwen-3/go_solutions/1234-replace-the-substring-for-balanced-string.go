package main

func replaceSubstring(s string, k int) int {
    count := make(map[byte]int)
    for i := 0; i < len(s); i++ {
        count[s[i]]++
    }
    if count['a'] <= k && count['b'] <= k && count['c'] <= k && count['d'] <= k {
        return 0
    }
    left := 0
    minLen := len(s)
    for right := 0; right < len(s); right++ {
        count[s[right]]--
        for count['a'] <= k && count['b'] <= k && count['c'] <= k && count['d'] <= k {
            minLen = min(minLen, right-left+1)
            count[s[left]]++
            left++
        }
    }
    return minLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}