package main

func closestToTarget(arr []int, target int) int {
    n := len(arr)
    res := 1 << 30
    s := make(map[int]bool)
    for i := 0; i < n; i++ {
        new_s := make(map[int]bool)
        new_s[arr[i]] = true
        if arr[i] == target {
            return 0
        }
        res = min(res, abs(arr[i]-target))
        for key := range s {
            new_s[key&arr[i]] = true
            res = min(res, abs(key&arr[i]-target))
        }
        s = new_s
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}