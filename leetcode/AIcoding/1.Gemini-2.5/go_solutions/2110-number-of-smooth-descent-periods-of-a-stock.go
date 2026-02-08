func smoothDescentPeriods(prices []int) int64 {
    n := len(prices)
    if n == 0 {
        return 0
    }

    var totalSmoothPeriods int64
    currentLength := 0

    for i := 0; i < n; i++ {
        if i == 0 || prices[i-1]-prices[i] != 1 {
            currentLength = 1
        } else {
            currentLength++
        }
        totalSmoothPeriods += int64(currentLength)
    }

    return totalSmoothPeriods
}