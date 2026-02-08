func minTimeToFinishRace(time []int, totalTime int) int {
    left, right := 1, totalTime
    for left < right {
        mid := left + (right-left)/2
        if canFinish(time, mid, totalTime) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canFinish(time []int, speed int, totalTime int) bool {
    totalDistance := 0
    for _, t := range time {
        totalDistance += totalTime / t * speed
        if totalDistance >= speed {
            return true
        }
    }
    return false
}