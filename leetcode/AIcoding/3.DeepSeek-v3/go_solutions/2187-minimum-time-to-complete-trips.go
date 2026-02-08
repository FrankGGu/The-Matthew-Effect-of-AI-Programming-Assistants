func minimumTime(time []int, totalTrips int) int64 {
    left := int64(1)
    maxTime := int64(0)
    for _, t := range time {
        if int64(t) > maxTime {
            maxTime = int64(t)
        }
    }
    right := maxTime * int64(totalTrips)

    for left < right {
        mid := left + (right-left)/2
        total := int64(0)
        for _, t := range time {
            total += mid / int64(t)
        }
        if total >= int64(totalTrips) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}