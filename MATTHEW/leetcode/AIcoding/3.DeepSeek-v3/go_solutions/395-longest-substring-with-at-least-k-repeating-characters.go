func longestSubstring(s string, k int) int {
    if len(s) == 0 || k > len(s) {
        return 0
    }
    if k <= 1 {
        return len(s)
    }

    freq := make(map[rune]int)
    for _, ch := range s {
        freq[ch]++
    }

    for i := 0; i < len(s); i++ {
        if freq[rune(s[i])] >= k {
            continue
        }
        j := i + 1
        for j < len(s) && freq[rune(s[j])] < k {
            j++
        }
        left := longestSubstring(s[:i], k)
        right := longestSubstring(s[j:], k)
        return max(left, right)
    }
    return len(s)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}