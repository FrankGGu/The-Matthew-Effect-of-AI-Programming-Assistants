func maximumWealth(accounts [][]int) int {
    maxWealth := 0
    for _, customer := range accounts {
        wealth := 0
        for _, money := range customer {
            wealth += money
        }
        if wealth > maxWealth {
            maxWealth = wealth
        }
    }
    return maxWealth
}