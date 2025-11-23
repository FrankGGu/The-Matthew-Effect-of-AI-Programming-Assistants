func maxNumOfSubstrings(s string) []string {
    n := len(s)
    left := make([]int, n)
    right := make([]int, n)
    minLeft, maxRight := make([]int, 26), make([]int, 26)

    for i := 0; i < 26; i++ {
        minLeft[i] = n
        maxRight[i] = -1
    }

    for i := 0; i < n; i++ {
        c := s[i] - 'a'
        minLeft[c] = min(minLeft[c], i)
        maxRight[c] = max(maxRight[c], i)
    }

    for i := 0; i < 26; i++ {
        if minLeft[i] != n {
            l, r := minLeft[i], maxRight[i]
            for j := l; j <= r; j++ {
                c := s[j] - 'a'
                r = max(r, maxRight[c])
            }
            left[i] = l
            right[i] = r
        }
    }

    ans := []string{}
    for i := 0; i < 26; i++ {
        if left[i] < right[i] {
            ans = append(ans, s[left[i]:right[i]+1])
        }
    }

    sort.Slice(ans, func(i, j int) bool {
        if len(ans[i]) == len(ans[j]) {
            return ans[i] < ans[j]
        }
        return len(ans[i]) < len(ans[j])
    })

    result := []string{}
    lastEnd := -1
    for _, substring := range ans {
        if len(substring) == 0 || len(result) > 0 && lastEnd >= left[substring[0]-'a'] {
            continue
        }
        result = append(result, substring)
        lastEnd = right[substring[0]-'a']
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}