func maximumWealth(accounts [][]int) int {
    maxWealth := 0
    for _, account := range accounts {
        wealth := 0
        for _, amount := range account {
            wealth += amount
        }
        if wealth > maxWealth {
            maxWealth = wealth
        }
    }
    return maxWealth
}