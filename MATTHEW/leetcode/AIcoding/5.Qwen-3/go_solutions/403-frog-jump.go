package main

func canCross(stones []int) bool {
    if stones[0] != 0 {
        return false
    }
    if len(stones) == 1 {
        return true
    }
    memo := make(map[int]map[int]bool)
    return dfs(stones, 0, 0, memo)
}

func dfs(stones []int, index int, jump int, memo map[int]map[int]bool) bool {
    if index == len(stones)-1 {
        return true
    }
    if _, ok := memo[index]; !ok {
        memo[index] = make(map[int]bool)
    }
    if memo[index][jump] {
        return false
    }
    for i := index + 1; i < len(stones); i++ {
        k := stones[i] - stones[index]
        if k < 0 || k > jump+1 {
            break
        }
        if k == jump-1 || k == jump || k == jump+1 {
            if dfs(stones, i, k, memo) {
                return true
            }
        }
        memo[index][jump] = true
    }
    return false
}