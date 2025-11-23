func makesquare(matchsticks []int) bool {
    if len(matchsticks) < 4 {
        return false
    }
    total := 0
    for _, v := range matchsticks {
        total += v
    }
    if total%4 != 0 {
        return false
    }
    target := total / 4
    sort.Sort(sort.Reverse(sort.IntSlice(matchsticks)))
    sides := make([]int, 4)
    var backtrack func(int) bool
    backtrack = func(index int) bool {
        if index == len(matchsticks) {
            return true
        }
        for i := 0; i < 4; i++ {
            if sides[i]+matchsticks[index] <= target {
                sides[i] += matchsticks[index]
                if backtrack(index + 1) {
                    return true
                }
                sides[i] -= matchsticks[index]
            }
        }
        return false
    }
    return backtrack(0)
}