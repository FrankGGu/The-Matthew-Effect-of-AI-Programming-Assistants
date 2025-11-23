package main

func maximumTotalReward(s []int) int {
    sort.Ints(s)
    n := len(s)
    dp := make(map[int]int)
    for i := 0; i < n; i++ {
        if i > 0 && s[i] == s[i-1] {
            continue
        }
        val := s[i]
        newDp := make(map[int]int)
        for k, v := range dp {
            if k > val {
                newDp[k] = max(v, newDp[k])
            } else {
                newDp[val+v] = max(v, newDp[val+v])
            }
        }
        newDp[val] = max(1, newDp[val])
        dp = newDp
    }
    maxVal := 0
    for _, v := range dp {
        if v > maxVal {
            maxVal = v
        }
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}