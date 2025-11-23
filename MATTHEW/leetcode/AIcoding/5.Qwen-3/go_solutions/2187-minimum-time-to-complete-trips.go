package main

func minimumTime(totalTrips int, time []int) int {
	left := 1
	right := int64(1e18)

	for left < int(right) {
		mid := (left + int(right)) / 2
		total := 0
		for _, t := range time {
			total += int(mid / int64(t))
			if total >= totalTrips {
				break
			}
		}
		if total >= totalTrips {
			right = int64(mid)
		} else {
			left = mid + 1
		}
	}
	return left
}