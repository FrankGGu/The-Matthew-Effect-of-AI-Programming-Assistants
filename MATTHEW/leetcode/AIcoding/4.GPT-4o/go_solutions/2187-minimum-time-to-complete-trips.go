func minimumTime(time []int, totalTrips int64) int64 {
    left, right := int64(1), int64(1e14)
    for left < right {
        mid := left + (right-left)/2
        trips := int64(0)
        for _, t := range time {
            trips += mid / int64(t)
            if trips >= totalTrips {
                break
            }
        }
        if trips >= totalTrips {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}