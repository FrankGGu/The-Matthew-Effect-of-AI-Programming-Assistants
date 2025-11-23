func punishmentNumber(n int) int {
    total := 0
    for i := 1; i <= n; i++ {
        if isPunishmentNumber(i) {
            total += i * i
        }
    }
    return total
}

func isPunishmentNumber(num int) bool {
    strNum := strconv.Itoa(num)
    return dfs(strNum, 0, 0)
}

func dfs(s string, index, sum int) bool {
    if index == len(s) {
        return sum == 0
    }
    for i := index; i < len(s); i++ {
        part, _ := strconv.Atoi(s[index : i+1])
        if part == 0 || part > sum {
            continue
        }
        if dfs(s, i+1, sum-part) {
            return true
        }
    }
    return false
}