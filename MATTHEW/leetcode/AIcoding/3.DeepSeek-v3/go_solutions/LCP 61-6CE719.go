func temperatureTrend(temperatureA []int, temperatureB []int) int {
    n := len(temperatureA)
    if n <= 1 {
        return 0
    }
    maxLen, current := 0, 0
    for i := 1; i < n; i++ {
        trendA := 0
        if temperatureA[i] > temperatureA[i-1] {
            trendA = 1
        } else if temperatureA[i] < temperatureA[i-1] {
            trendA = -1
        }
        trendB := 0
        if temperatureB[i] > temperatureB[i-1] {
            trendB = 1
        } else if temperatureB[i] < temperatureB[i-1] {
            trendB = -1
        }
        if trendA == trendB {
            current++
            if current > maxLen {
                maxLen = current
            }
        } else {
            current = 0
        }
    }
    return maxLen
}