func minimumAddedCoins(coins []int, target int) int {
    sort.Ints(coins)
    res := 0
    maxReach := 0
    i := 0
    for maxReach < target {
        if i < len(coins) && coins[i] <= maxReach + 1 {
            maxReach += coins[i]
            i++
        } else {
            maxReach += maxReach + 1
            res++
        }
    }
    return res
}