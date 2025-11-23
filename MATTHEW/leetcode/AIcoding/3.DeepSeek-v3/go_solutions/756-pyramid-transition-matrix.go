func pyramidTransition(bottom string, allowed []string) bool {
    pyramid := make(map[string][]byte)
    for _, a := range allowed {
        key := a[:2]
        pyramid[key] = append(pyramid[key], a[2])
    }

    var dfs func(current, next string, idx int) bool
    dfs = func(current, next string, idx int) bool {
        if len(current) == 1 {
            return true
        }
        if idx == len(current)-1 {
            return dfs(next, "", 0)
        }
        key := current[idx:idx+2]
        if _, exists := pyramid[key]; !exists {
            return false
        }
        for _, ch := range pyramid[key] {
            if dfs(current, next + string(ch), idx+1) {
                return true
            }
        }
        return false
    }

    return dfs(bottom, "", 0)
}