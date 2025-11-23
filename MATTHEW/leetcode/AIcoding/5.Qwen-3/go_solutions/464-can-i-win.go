package main

func canIWin(maxInt int, desiredTotal int) bool {
    memo := make(map[int]bool)
    return canIWinHelper(maxInt, desiredTotal, 0, 0, memo)
}

func canIWinHelper(maxInt int, desiredTotal int, used int, currentSum int, memo map[int]bool) bool {
    if val, ok := memo[used]; ok {
        return val
    }

    for i := 1; i <= maxInt; i++ {
        if (used & (1 << (i - 1))) == 0 {
            if currentSum+i >= desiredTotal {
                memo[used] = true
                return true
            }
            newUsed := used | (1 << (i - 1))
            if !canIWinHelper(maxInt, desiredTotal, newUsed, currentSum+i, memo) {
                memo[used] = true
                return true
            }
        }
    }

    memo[used] = false
    return false
}