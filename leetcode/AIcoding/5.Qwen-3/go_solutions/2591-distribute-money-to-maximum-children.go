package main

func distributeMoney(total int, moneyPerChild int) int {
    if moneyPerChild == 0 {
        return 0
    }
    return (total - 1) / (moneyPerChild - 1)
}