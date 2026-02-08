func splitString(s string) bool {
    n := len(s)
    var dfs func(int, int, int) bool
    dfs = func(index, prev, count int) bool {
        if index == n {
            return count >= 2
        }
        current := 0
        for i := index; i < n; i++ {
            current = current*10 + int(s[i]-'0')
            if prev == -1 || current == prev-1 {
                if dfs(i+1, current, count+1) {
                    return true
                }
            } else if prev != -1 && current > prev {
                break
            }
        }
        return false
    }
    return dfs(0, -1, 0)
}