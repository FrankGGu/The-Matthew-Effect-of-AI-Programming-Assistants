func distributeCookies(cookies []int, k int) int {
    n := len(cookies)
    res := 1 << 31 - 1
    var backtrack func(int, []int)
    backtrack = func(idx int, children []int) {
        if idx == n {
            max := 0
            for _, v := range children {
                if v > max {
                    max = v
                }
            }
            if max < res {
                res = max
            }
            return
        }
        for i := 0; i < k; i++ {
            children[i] += cookies[idx]
            backtrack(idx+1, children)
            children[i] -= cookies[idx]
            if children[i] == 0 {
                break
            }
        }
    }
    backtrack(0, make([]int, k))
    return res
}