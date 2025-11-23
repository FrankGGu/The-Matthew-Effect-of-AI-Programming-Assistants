func minimumTime(time []int, totalTrips int) int64 {
	l, r := int64(1), int64(1e14)
	for l < r {
		mid := l + (r-l)/2
		trips := 0
		for _, t := range time {
			trips += int(mid / int64(t))
		}
		if trips >= totalTrips {
			r = mid
		} else {
			l = mid + 1
		}
	}
	return l
}