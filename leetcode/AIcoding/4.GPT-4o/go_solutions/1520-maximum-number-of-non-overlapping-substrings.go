func maxNumOfSubstrings(s string) []string {
    n := len(s)
    left := make([]int, n)
    right := make([]int, n)
    last := make([]int, 26)
    ans := []string{}

    for i := 0; i < n; i++ {
        last[s[i]-'a'] = i
    }

    for i := n - 1; i >= 0; i-- {
        right[i] = last[s[i]-'a']
    }

    for i := 0; i < n; i++ {
        if last[s[i]-'a'] == 0 && last[s[i]-'a'] < i {
            continue
        }
        end := right[i]
        for j := i; j <= end; j++ {
            end = max(end, right[j])
        }
        left[end] = max(left[end], end-i+1)
    }

    for i := 0; i < n; i++ {
        if left[i] > 0 {
            ans = append(ans, s[i:left[i]])
        }
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}