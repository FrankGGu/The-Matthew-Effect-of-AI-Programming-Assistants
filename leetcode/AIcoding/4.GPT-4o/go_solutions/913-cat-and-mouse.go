func catMouseGame(graph [][]int) int {
    n := len(graph)
    memo := make(map[[3]int]int)

    var dfs func(cat, mouse, t int) int
    dfs = func(cat, mouse, t int) int {
        if cat == mouse {
            return 1
        }
        if t == 2*n {
            return 0
        }
        if res, found := memo[[3]int{cat, mouse, t}]; found {
            return res
        }
        if t%2 == 0 {
            for _, nextCat := range graph[cat] {
                if nextCat != 0 {
                    if dfs(nextCat, mouse, t+1) == 1 {
                        memo[[3]int{cat, mouse, t}] = 1
                        return 1
                    }
                }
            }
            memo[[3]int{cat, mouse, t}] = 2
            return 2
        } else {
            for _, nextMouse := range graph[mouse] {
                if nextMouse != 0 {
                    if dfs(cat, nextMouse, t+1) == 2 {
                        memo[[3]int{cat, mouse, t}] = 2
                        return 2
                    }
                }
            }
            memo[[3]int{cat, mouse, t}] = 1
            return 1
        }
    }

    return dfs(1, 2, 0)
}