func lexicalOrder(n int) []int {
    result := []int{}
    var dfs func(int)
    dfs = func(cur int) {
        if cur > n {
            return
        }
        result = append(result, cur)
        for i := 0; i < 10; i++ {
            next := cur*10 + i
            if next > n {
                break
            }
            dfs(next)
        }
    }
    for i := 1; i <= 9; i++ {
        dfs(i)
    }
    return result
}