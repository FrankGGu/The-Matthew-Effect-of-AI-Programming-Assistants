func makesquare(matchsticks []int) bool {
    totalLength := 0
    for _, m := range matchsticks {
        totalLength += m
    }
    if totalLength%4 != 0 {
        return false
    }
    sideLength := totalLength / 4
    sides := make([]int, 4)

    var backtrack func(int) bool
    backtrack = func(index int) bool {
        if index == len(matchsticks) {
            return sides[0] == sideLength && sides[1] == sideLength && sides[2] == sideLength
        }
        for i := 0; i < 4; i++ {
            if sides[i]+matchsticks[index] <= sideLength {
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