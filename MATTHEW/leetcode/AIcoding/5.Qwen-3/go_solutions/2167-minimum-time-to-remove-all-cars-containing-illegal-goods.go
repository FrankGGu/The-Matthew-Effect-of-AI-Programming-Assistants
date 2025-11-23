package main

func minTime(removeTime []int, broken []bool) int {
    n := len(removeTime)
    res := 0
    for i := 0; i < n; i++ {
        if broken[i] {
            res += removeTime[i]
        }
    }
    return res
}