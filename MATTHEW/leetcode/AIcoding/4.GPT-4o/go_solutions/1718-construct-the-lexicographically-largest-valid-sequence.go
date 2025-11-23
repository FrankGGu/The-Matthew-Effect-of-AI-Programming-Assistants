func constructDistancedSequence(n int) []int {
    result := make([]int, 2*n-1)
    used := make([]bool, n+1)
    var backtrack func(pos int) bool
    backtrack = func(pos int) bool {
        if pos == len(result) {
            return true
        }
        if result[pos] != 0 {
            return backtrack(pos + 1)
        }
        for i := n; i >= 1; i-- {
            if !used[i] {
                if i == 1 {
                    used[i] = true
                    result[pos] = i
                    if backtrack(pos + 1) {
                        return true
                    }
                    used[i] = false
                    result[pos] = 0
                } else if pos+i < len(result) && result[pos+i] == 0 {
                    used[i] = true
                    result[pos] = i
                    result[pos+i] = i
                    if backtrack(pos + 1) {
                        return true
                    }
                    used[i] = false
                    result[pos] = 0
                    result[pos+i] = 0
                }
            }
        }
        return false
    }
    backtrack(0)
    return result
}