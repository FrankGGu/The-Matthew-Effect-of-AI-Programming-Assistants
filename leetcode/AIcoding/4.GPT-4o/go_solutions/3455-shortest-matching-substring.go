func minWindow(s string, t string) string {
    if len(t) == 0 || len(s) < len(t) {
        return ""
    }

    dictT := make(map[rune]int)
    for _, char := range t {
        dictT[char]++
    }

    required := len(dictT)
    l, r := 0, 0
    formed := 0
    windowCounts := make(map[rune]int)

    ans := []int{-1, 0, 0}

    for r < len(s) {
        char := rune(s[r])
        windowCounts[char]++

        if _, ok := dictT[char]; ok && windowCounts[char] == dictT[char] {
            formed++
        }

        for l <= r && formed == required {
            char = rune(s[l])

            if ans[0] == -1 || r-l+1 < ans[0] {
                ans[0] = r - l + 1
                ans[1] = l
                ans[2] = r
            }

            windowCounts[char]--
            if _, ok := dictT[char]; ok && windowCounts[char] < dictT[char] {
                formed--
            }
            l++
        }
        r++
    }

    if ans[0] == -1 {
        return ""
    }
    return s[ans[1]:ans[2]+1]
}