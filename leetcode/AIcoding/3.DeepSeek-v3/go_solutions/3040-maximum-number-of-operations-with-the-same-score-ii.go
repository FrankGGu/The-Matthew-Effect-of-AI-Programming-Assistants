func maxOperations(nums []int) int {
    n := len(nums)
    if n < 2 {
        return 0
    }

    memo := make(map[string]int)

    var dfs func(l, r, score int) int
    dfs = func(l, r, score int) int {
        if l >= r {
            return 0
        }
        key := fmt.Sprintf("%d,%d,%d", l, r, score)
        if val, ok := memo[key]; ok {
            return val
        }

        res := 0
        if nums[l] + nums[l+1] == score {
            res = max(res, 1 + dfs(l+2, r, score))
        }
        if nums[r] + nums[r-1] == score {
            res = max(res, 1 + dfs(l, r-2, score))
        }
        if nums[l] + nums[r] == score {
            res = max(res, 1 + dfs(l+1, r-1, score))
        }

        memo[key] = res
        return res
    }

    option1 := dfs(2, n-1, nums[0]+nums[1])
    option2 := dfs(0, n-3, nums[n-1]+nums[n-2])
    option3 := dfs(1, n-2, nums[0]+nums[n-1])

    return 1 + max(option1, max(option2, option3))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}