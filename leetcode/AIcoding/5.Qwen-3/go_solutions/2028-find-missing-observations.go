package main

func missingRolls(rolls []int, mean int, n int) []int {
    m := len(rolls)
    sum := 0
    for _, r := range rolls {
        sum += r
    }
    total := mean * (m + n)
    missing := total - sum
    if missing < n || missing > 6*n {
        return []int{}
    }
    res := make([]int, n)
    base := missing / n
    remainder := missing % n
    for i := 0; i < n; i++ {
        if i < remainder {
            res[i] = base + 1
        } else {
            res[i] = base
        }
    }
    return res
}