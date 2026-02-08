package main

func maxActiveSections(sections []int, trades []int) int {
    n := len(sections)
    m := len(trades)
    res := 0
    for i := 0; i < n; i++ {
        if sections[i] == 0 {
            continue
        }
        count := 1
        j := i + 1
        for j < n && sections[j] > 0 {
            count++
            j++
        }
        i = j - 1
        res = max(res, count)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}