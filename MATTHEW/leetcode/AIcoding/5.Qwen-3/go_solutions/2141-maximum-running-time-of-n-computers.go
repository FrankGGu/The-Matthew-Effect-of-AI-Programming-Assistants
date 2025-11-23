package main

func maxRunTime(n int, batteries []int) int {
    sort.Ints(batteries)
    total := 0
    for _, v := range batteries {
        total += v
    }
    for i := len(batteries) - 1; i >= 0; i-- {
        if batteries[i] > total / n {
            total -= batteries[i]
            n--
        } else {
            break
        }
    }
    return total / n
}