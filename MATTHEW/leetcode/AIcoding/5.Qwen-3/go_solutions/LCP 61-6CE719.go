package main

func temperatureTrend(temperatureA []int, temperatureB []int) int {
    max := 0
    current := 0
    for i := 1; i < len(temperatureA); i++ {
        a := temperatureA[i] - temperatureA[i-1]
        b := temperatureB[i] - temperatureB[i-1]
        if (a > 0 && b > 0) || (a < 0 && b < 0) {
            current++
            if current > max {
                max = current
            }
        } else {
            current = 0
        }
    }
    return max
}