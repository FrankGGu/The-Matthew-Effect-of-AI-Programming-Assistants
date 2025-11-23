func maxPower(n int, stations []int, power []int) int {
    left, right := 1, int(1e9)
    for left < right {
        mid := left + (right-left)/2
        if canDistributePower(mid, stations, power) {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left - 1
}

func canDistributePower(minPower int, stations []int, power []int) bool {
    totalPower := 0
    for i := 0; i < len(stations); i++ {
        totalPower += power[i] / minPower
    }
    return totalPower >= len(stations)
}