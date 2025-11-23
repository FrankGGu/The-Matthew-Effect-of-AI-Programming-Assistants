package main

func minGroups(usageLimits []int) int {
    sort.Ints(usageLimits)
    n := len(usageLimits)
    res := 0
    for i := 0; i < n; i++ {
        if usageLimits[i] == 0 {
            continue
        }
        cnt := 1
        j := i + 1
        for j < n && usageLimits[j] >= usageLimits[i]-1 {
            if usageLimits[j] == usageLimits[i]-1 {
                cnt++
            }
            j++
        }
        res = max(res, cnt)
        i = j - 1
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}