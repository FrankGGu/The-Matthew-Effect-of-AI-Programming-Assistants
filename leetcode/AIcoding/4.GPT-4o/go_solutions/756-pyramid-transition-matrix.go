func pyramidTransition(bottom string, allowed []string) bool {
    allowedMap := make(map[string]map[rune]bool)
    for _, a := range allowed {
        if allowedMap[a[:2]] == nil {
            allowedMap[a[:2]] = make(map[rune]bool)
        }
        allowedMap[a[:2]][rune(a[2])] = true
    }

    var dfs func(string) bool
    dfs = func(current string) bool {
        if len(current) == 1 {
            return true
        }
        nextLevel := ""
        for i := 0; i < len(current)-1; i++ {
            found := false
            for ch := range allowedMap[current[i:i+2]] {
                nextLevel += string(ch)
                found = true
            }
            if !found {
                return false
            }
        }
        return dfs(nextLevel)
    }
    return dfs(bottom)
}