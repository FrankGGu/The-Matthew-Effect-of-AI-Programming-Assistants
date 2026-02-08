package main

func minCost(startString string, target string, cost []int) int {
    if len(startString) != len(target) {
        return -1
    }
    n := len(startString)
    res := 0
    i := 0
    for i < n {
        if startString[i] == target[i] {
            i++
            continue
        }
        j := i
        for j < n && startString[j] == target[i] {
            j++
        }
        if j == i {
            return -1
        }
        maxCost := 0
        for k := i; k < j; k++ {
            if startString[k] == target[i] {
                maxCost = max(maxCost, cost[k])
            }
        }
        if maxCost == 0 {
            return -1
        }
        res += maxCost
        i = j
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}