func numsSameConsecDiff(N int, K int) []int {
    if N == 1 {
        return []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
    }
    result := []int{}
    var dfs func(num int, length int)
    dfs = func(num int, length int) {
        if length == N {
            result = append(result, num)
            return
        }
        lastDigit := num % 10
        if lastDigit+K < 10 {
            dfs(num*10+lastDigit+K, length+1)
        }
        if K > 0 && lastDigit-K >= 0 {
            dfs(num*10+lastDigit-K, length+1)
        }
    }
    for i := 1; i < 10; i++ {
        dfs(i, 1)
    }
    return result
}