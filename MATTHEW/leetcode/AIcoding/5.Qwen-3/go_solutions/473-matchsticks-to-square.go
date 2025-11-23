package main

func matchsticksToSquare(matchsticks []int) bool {
    total := 0
    for _, v := range matchsticks {
        total += v
    }
    if total%4 != 0 {
        return false
    }
    target := total / 4
    if len(matchsticks) == 0 {
        return true
    }
    sort.Ints(matchsticks)
    if matchsticks[len(matchsticks)-1] > target {
        return false
    }
    used := make([]bool, len(matchsticks))
    var backtrack func(int, int) bool
    backtrack = func(start int, currentSum int) bool {
        if currentSum == target {
            return true
        }
        for i := start; i < len(matchsticks); i++ {
            if used[i] || currentSum+matchsticks[i] > target {
                continue
            }
            used[i] = true
            if backtrack(i+1, currentSum+matchsticks[i]) {
                return true
            }
            used[i] = false
        }
        return false
    }
    return backtrack(0, 0)
}