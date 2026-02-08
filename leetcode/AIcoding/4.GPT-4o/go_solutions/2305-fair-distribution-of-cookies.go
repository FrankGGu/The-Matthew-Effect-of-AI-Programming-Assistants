func distributeCookies(cookies []int, k int) int {
    n := len(cookies)
    ans := math.MaxInt32
    distribution := make([]int, k)

    var backtrack func(index int)
    backtrack = func(index int) {
        if index == n {
            maxCookies := 0
            for _, d := range distribution {
                if d > maxCookies {
                    maxCookies = d
                }
            }
            ans = min(ans, maxCookies)
            return
        }

        for i := 0; i < k; i++ {
            distribution[i] += cookies[index]
            backtrack(index + 1)
            distribution[i] -= cookies[index]
        }
    }

    backtrack(0)
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}