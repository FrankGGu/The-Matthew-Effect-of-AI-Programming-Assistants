func maximumLength(s string) int {
    n := len(s)
    freq := make([][]int, 26)
    for i := range freq {
        freq[i] = make([]int, n+2)
    }

    current := 1
    for i := 1; i <= n; i++ {
        if i < n && s[i] == s[i-1] {
            current++
        } else {
            c := int(s[i-1] - 'a')
            for k := 1; k <= current; k++ {
                freq[c][k] += current - k + 1
            }
            current = 1
        }
    }

    maxLen := -1
    for c := 0; c < 26; c++ {
        for k := n; k >= 1; k-- {
            if freq[c][k] >= 3 {
                if k > maxLen {
                    maxLen = k
                }
                break
            }
        }
    }
    return maxLen
}