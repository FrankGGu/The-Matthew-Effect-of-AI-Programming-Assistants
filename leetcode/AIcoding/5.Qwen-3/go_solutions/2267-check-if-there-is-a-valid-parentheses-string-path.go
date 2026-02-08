package main

func checkValidString(s string) bool {
    n := len(s)
    memo := make(map[string]bool)
    var dfs func(int, int) bool
    dfs = func(i, balance int) bool {
        if i == n {
            return balance == 0
        }
        key := fmt.Sprintf("%d,%d", i, balance)
        if val, ok := memo[key]; ok {
            return val
        }
        if s[i] == '(' {
            if dfs(i+1, balance+1) {
                memo[key] = true
                return true
            }
        } else if s[i] == ')' {
            if balance > 0 && dfs(i+1, balance-1) {
                memo[key] = true
                return true
            }
        } else {
            if dfs(i+1, balance+1) || (balance > 0 && dfs(i+1, balance-1)) || dfs(i+1, balance) {
                memo[key] = true
                return true
            }
        }
        memo[key] = false
        return false
    }
    return dfs(0, 0)
}