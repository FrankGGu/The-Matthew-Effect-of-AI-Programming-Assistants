func splitString(s string) bool {
    n := len(s)
    var backtrack func(int, int, int) bool
    backtrack = func(start, prev, count int) bool {
        if start == n {
            return count >= 2
        }
        current := 0
        for i := start; i < n; i++ {
            current = current * 10 + int(s[i]-'0')
            if count == 0 || current == prev-1 {
                if backtrack(i+1, current, count+1) {
                    return true
                }
            }
            if current > prev && count != 0 {
                break
            }
        }
        return false
    }
    return backtrack(0, 0, 0)
}