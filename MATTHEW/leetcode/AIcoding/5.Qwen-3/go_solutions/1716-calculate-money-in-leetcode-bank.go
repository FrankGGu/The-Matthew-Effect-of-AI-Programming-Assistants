package main

func totalMoney(n int) int {
    total := 0
    for i := 0; i < n; i++ {
        total += 28 + (i/7)*7 + i%7
    }
    return total
}