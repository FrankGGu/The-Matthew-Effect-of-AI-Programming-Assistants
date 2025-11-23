func minSpeedOnTime(dist []int, hour float64) int {
    left, right := 1, 10000000
    result := -1

    for left <= right {
        mid := left + (right-left)/2
        if canArrive(dist, mid, hour) {
            result = mid
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    return result
}

func canArrive(dist []int, speed int, hour float64) bool {
    total := 0.0
    for i := 0; i < len(dist)-1; i++ {
        time := float64(dist[i]) / float64(speed)
        total += math.Ceil(time)
    }
    total += float64(dist[len(dist)-1]) / float64(speed)
    return total <= hour
}