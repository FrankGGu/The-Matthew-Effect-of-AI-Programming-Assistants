package main

func combinationSum4(nums []int, target int) int {
    memo := make(map[int]int)
    var dfs func(int) int
    dfs = func(n int) int {
        if n == 0 {
            return 1
        }
        if val, ok := memo[n]; ok {
            return val
        }
        count := 0
        for _, num := range nums {
            if n >= num {
                count += dfs(n - num)
            }
        }
        memo[n] = count
        return count
    }
    return dfs(target)
}