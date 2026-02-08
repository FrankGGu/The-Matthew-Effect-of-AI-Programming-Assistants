package main

func minTimeToBuyPotions(time []int, people int) int {
    sort.Ints(time)
    res := 0
    for i := 0; i < len(time); i++ {
        res += time[i] * (i + 1)
    }
    return res
}