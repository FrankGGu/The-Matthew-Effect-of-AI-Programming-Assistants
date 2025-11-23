func lexicalOrder(n int) []int {
    res := make([]int, 0, n)
    var dfs func(int)
    dfs = func(curr int) {
        if curr > n {
            return
        }
        res = append(res, curr)
        for i := 0; i <= 9; i++ {
            next := curr*10 + i
            if next > n {
                break
            }
            dfs(next)
        }
    }
    for i := 1; i <= 9; i++ {
        dfs(i)
    }
    return res
}