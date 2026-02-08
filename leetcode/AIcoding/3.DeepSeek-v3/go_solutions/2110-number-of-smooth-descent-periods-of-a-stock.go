func getDescentPeriods(prices []int) int64 {
    var total int64 = 0
    current := 1
    for i := 1; i < len(prices); i++ {
        if prices[i] == prices[i-1]-1 {
            current++
        } else {
            total += int64(current * (current + 1) / 2)
            current = 1
        }
    }
    total += int64(current * (current + 1) / 2)
    return total
}