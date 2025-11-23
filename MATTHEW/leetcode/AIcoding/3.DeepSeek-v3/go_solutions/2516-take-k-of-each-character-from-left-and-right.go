func takeCharacters(s string, k int) int {
    n := len(s)
    count := make(map[byte]int)
    for i := 0; i < n; i++ {
        count[s[i]]++
    }
    if count['a'] < k || count['b'] < k || count['c'] < k {
        return -1
    }

    left := 0
    res := n
    for right := 0; right < n; right++ {
        count[s[right]]--
        for count['a'] < k || count['b'] < k || count['c'] < k {
            count[s[left]]++
            left++
        }
        res = min(res, n - (right - left + 1))
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}