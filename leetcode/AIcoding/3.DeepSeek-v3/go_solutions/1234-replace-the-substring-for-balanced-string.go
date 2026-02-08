func balancedString(s string) int {
    count := make(map[byte]int)
    n := len(s)
    res := n
    left := 0

    for i := 0; i < n; i++ {
        count[s[i]]++
    }

    for right := 0; right < n; right++ {
        count[s[right]]--
        for left < n && count['Q'] <= n/4 && count['W'] <= n/4 && count['E'] <= n/4 && count['R'] <= n/4 {
            res = min(res, right - left + 1)
            count[s[left]]++
            left++
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}