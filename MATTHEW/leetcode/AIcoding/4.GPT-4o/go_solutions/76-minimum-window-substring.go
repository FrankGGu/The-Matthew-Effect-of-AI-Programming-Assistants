func minWindow(s string, t string) string {
    if len(t) == 0 || len(s) < len(t) {
        return ""
    }

    dictT := make(map[rune]int)
    for _, char := range t {
        dictT[char]++
    }

    required := len(dictT)
    left, right := 0, 0
    formed := 0
    windowCounts := make(map[rune]int)
    ans := []int{-1, 0, 0}

    for right < len(s) {
        char := rune(s[right])
        windowCounts[char]++

        if _, ok := dictT[char]; ok && windowCounts[char] == dictT[char] {
            formed++
        }

        for left <= right && formed == required {
            char = rune(s[left])

            if ans[0] == -1 || right-left+1 < ans[0] {
                ans[0] = right - left + 1
                ans[1] = left
                ans[2] = right
            }

            windowCounts[char]--
            if _, ok := dictT[char]; ok && windowCounts[char] < dictT[char] {
                formed--
            }
            left++
        }
        right++
    }

    if ans[0] == -1 {
        return ""
    }
    return s[ans[1] : ans[2]+1]
}