package main

func maxActiveSections(tradeTime []int) int {
    n := len(tradeTime)
    active := make([]int, n)
    for i := 0; i < n; i++ {
        active[i] = tradeTime[i]
    }
    for i := 1; i < n; i++ {
        if tradeTime[i] > tradeTime[i-1] {
            active[i] = active[i-1] + tradeTime[i]
        } else {
            active[i] = tradeTime[i]
        }
    }
    max := 0
    for _, v := range active {
        if v > max {
            max = v
        }
    }
    return max
}