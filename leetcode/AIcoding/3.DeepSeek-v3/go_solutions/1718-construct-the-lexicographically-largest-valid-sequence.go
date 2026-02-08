func constructDistancedSequence(n int) []int {
    size := 2*n - 1
    res := make([]int, size)
    used := make([]bool, n+1)

    var backtrack func(int) bool
    backtrack = func(pos int) bool {
        if pos == size {
            return true
        }
        if res[pos] != 0 {
            return backtrack(pos + 1)
        }
        for num := n; num >= 1; num-- {
            if used[num] {
                continue
            }
            if num == 1 {
                res[pos] = num
                used[num] = true
                if backtrack(pos + 1) {
                    return true
                }
                used[num] = false
                res[pos] = 0
            } else {
                if pos + num >= size || res[pos + num] != 0 {
                    continue
                }
                res[pos] = num
                res[pos + num] = num
                used[num] = true
                if backtrack(pos + 1) {
                    return true
                }
                used[num] = false
                res[pos] = 0
                res[pos + num] = 0
            }
        }
        return false
    }
    backtrack(0)
    return res
}