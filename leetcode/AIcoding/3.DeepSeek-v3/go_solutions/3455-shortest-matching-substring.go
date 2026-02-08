func minWindow(s string, t string) string {
    if len(s) == 0 || len(t) == 0 {
        return ""
    }

    dictT := make(map[byte]int)
    for i := 0; i < len(t); i++ {
        dictT[t[i]]++
    }

    required := len(dictT)
    formed := 0
    windowCounts := make(map[byte]int)
    ans := []int{-1, 0, 0}
    l, r := 0, 0

    for r < len(s) {
        c := s[r]
        windowCounts[c]++

        if count, ok := dictT[c]; ok && windowCounts[c] == count {
            formed++
        }

        for l <= r && formed == required {
            c := s[l]
            if ans[0] == -1 || r-l+1 < ans[0] {
                ans[0] = r - l + 1
                ans[1] = l
                ans[2] = r
            }

            windowCounts[c]--
            if count, ok := dictT[c]; ok && windowCounts[c] < count {
                formed--
            }
            l++
        }
        r++
    }

    if ans[0] == -1 {
        return ""
    }
    return s[ans[1] : ans[2]+1]
}