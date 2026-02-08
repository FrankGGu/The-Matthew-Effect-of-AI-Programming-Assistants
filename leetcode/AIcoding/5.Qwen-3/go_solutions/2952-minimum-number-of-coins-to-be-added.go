package main

func minimumCoins(coins []int, cost int) int {
    sort.Ints(coins)
    res := 0
    current := 0
    for current < cost {
        if len(coins) == 0 || coins[0] > current+1 {
            return -1
        }
        res += coins[0]
        current += coins[0]
        coins = coins[1:]
    }
    return res
}