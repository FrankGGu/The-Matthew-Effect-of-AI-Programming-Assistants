func getDescentPeriods(prices []int) int64 {
    n := len(prices)
    if n == 0 {
        return 0
    }

    totalPeriods := int64(n)
    currentPeriod := int64(1)

    for i := 1; i < n; i++ {
        if prices[i] == prices[i-1]-1 {
            currentPeriod++
        } else {
            currentPeriod = 1
        }
        totalPeriods += currentPeriod
    }

    return totalPeriods
}