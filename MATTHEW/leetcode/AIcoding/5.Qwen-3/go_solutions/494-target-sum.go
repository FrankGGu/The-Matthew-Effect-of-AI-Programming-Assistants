package main

func findTargetSumWays(nums []int, target int) int {
    n := len(nums)
    memo := make(map[string]int)

    var dfs func(int, int) int
    dfs = func(index, sum int) int {
        if index == n {
            if sum == target {
                return 1
            }
            return 0
        }
        key := fmt.Sprintf("%d,%d", index, sum)
        if val, ok := memo[key]; ok {
            return val
        }

        add := dfs(index+1, sum+nums[index])
        subtract := dfs(index+1, sum-nums[index])
        memo[key] = add + subtract
        return memo[key]
    }

    return dfs(0, 0)
}