package main

func punishmentNumber(n int) int {
    var result int
    for i := 1; i <= n; i++ {
        if isPunishable(i) {
            result += i * i
        }
    }
    return result
}

func isPunishable(n int) bool {
    s := strconv.Itoa(n)
    return backtrack(s, 0, 0, n)
}

func backtrack(s string, index int, currentSum int, target int) bool {
    if index == len(s) {
        return currentSum == target
    }
    for i := index; i < len(s); i++ {
        numStr := s[index:i+1]
        num, _ := strconv.Atoi(numStr)
        if currentSum+num > target {
            break
        }
        if backtrack(s, i+1, currentSum+num, target) {
            return true
        }
    }
    return false
}