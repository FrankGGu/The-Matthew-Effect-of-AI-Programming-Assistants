func minChanges(s string, k int) int {
    n := len(s)
    count := make([][26]int, k)
    for i := 0; i < n; i++ {
        count[i%k][s[i]-'a']++
    }

    res := 0
    for i := 0; i < (k+1)/2; i++ {
        left := count[i]
        right := count[k-1-i]
        total := 0
        maxFreq := 0

        for j := 0; j < 26; j++ {
            total += left[j] + right[j]
            maxFreq = max(maxFreq, left[j]+right[j])
        }
        res += total - maxFreq
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}