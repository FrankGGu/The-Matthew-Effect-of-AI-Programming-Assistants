package main

func maximumWealth(accounts [][]int) int {
    max := 0
    for _, account := range accounts {
        sum := 0
        for _, money := range account {
            sum += money
        }
        if sum > max {
            max = sum
        }
    }
    return max
}