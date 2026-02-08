package main

func minCost(str1 string, str2 string, x int, y int) int {
    if len(str1) != len(str2) {
        return -1
    }
    n := len(str1)
    cost := 0
    for i := 0; i < n; i++ {
        if str1[i] != str2[i] {
            if i+1 < n && str1[i] == str2[i+1] && str1[i+1] == str2[i] {
                cost += min(x, y)
                i++
            } else {
                cost += max(x, y)
            }
        }
    }
    return cost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}