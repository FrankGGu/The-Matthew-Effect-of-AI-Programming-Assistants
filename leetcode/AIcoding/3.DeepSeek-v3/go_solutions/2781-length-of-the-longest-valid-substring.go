func longestValidSubstring(word string, forbidden []string) int {
    forbiddenSet := make(map[string]bool)
    maxLen := 0
    for _, s := range forbidden {
        forbiddenSet[s] = true
        if len(s) > maxLen {
            maxLen = len(s)
        }
    }

    left := 0
    res := 0
    n := len(word)
    for right := 0; right < n; right++ {
        for l := 1; l <= maxLen && right - l + 1 >= left; l++ {
            sub := word[right - l + 1 : right + 1]
            if forbiddenSet[sub] {
                left = right - l + 2
                break
            }
        }
        if right - left + 1 > res {
            res = right - left + 1
        }
    }
    return res
}