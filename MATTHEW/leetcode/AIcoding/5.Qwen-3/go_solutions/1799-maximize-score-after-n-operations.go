package main

func maxScore(nums []int) int {
    n := len(nums)
    memo := make(map[int]int)

    var gcd func(a, b int) int
    gcd = func(a, b int) int {
        for b != 0 {
            a, b = b, a%b
        }
        return a
    }

    var dfs func(mask int) int
    dfs = func(mask int) int {
        if mask == (1 << n) - 1 {
            return 0
        }
        if val, ok := memo[mask]; ok {
            return val
        }

        res := 0
        for i := 0; i < n; i++ {
            if (mask & (1 << i)) == 0 {
                for j := i + 1; j < n; j++ {
                    if (mask & (1 << j)) == 0 {
                        newMask := mask | (1 << i) | (1 << j)
                        score := gcd(nums[i], nums[j]) * (n - 2)
                        nextScore := dfs(newMask)
                        res = max(res, score + nextScore)
                    }
                }
            }
        }
        memo[mask] = res
        return res
    }

    return dfs(0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}