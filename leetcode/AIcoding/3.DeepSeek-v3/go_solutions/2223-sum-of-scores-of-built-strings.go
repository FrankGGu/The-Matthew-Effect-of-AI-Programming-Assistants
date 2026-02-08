func sumScores(s string) int64 {
    n := len(s)
    z := make([]int, n)
    l, r := 0, 0
    for i := 1; i < n; i++ {
        if i <= r {
            z[i] = min(z[i-l], r-i+1)
        }
        for i+z[i] < n && s[z[i]] == s[i+z[i]] {
            z[i]++
        }
        if i+z[i]-1 > r {
            l, r = i, i+z[i]-1
        }
    }
    z[0] = n
    var res int64
    for _, num := range z {
        res += int64(num)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}