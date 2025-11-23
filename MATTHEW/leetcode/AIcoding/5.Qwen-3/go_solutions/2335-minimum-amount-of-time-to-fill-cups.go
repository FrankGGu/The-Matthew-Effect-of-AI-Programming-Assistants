package main

func fillCups(amount []int) int {
    max := 0
    sum := 0
    for _, v := range amount {
        if v > max {
            max = v
        }
        sum += v
    }
    if sum <= max*2 {
        return max
    }
    return (sum + 1) / 2
}