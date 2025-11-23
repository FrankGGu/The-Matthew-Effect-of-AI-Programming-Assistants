func numsSameConsecDiff(n int, k int) []int {
    result := []int{}
    var dfs func(num, digit, remaining int)
    dfs = func(num, digit, remaining int) {
        if remaining == 0 {
            result = append(result, num)
            return
        }
        if digit + k < 10 {
            dfs(num * 10 + (digit + k), digit + k, remaining - 1)
        }
        if k != 0 && digit - k >= 0 {
            dfs(num * 10 + (digit - k), digit - k, remaining - 1)
        }
    }
    for i := 1; i <= 9; i++ {
        dfs(i, i, n-1)
    }
    return result
}