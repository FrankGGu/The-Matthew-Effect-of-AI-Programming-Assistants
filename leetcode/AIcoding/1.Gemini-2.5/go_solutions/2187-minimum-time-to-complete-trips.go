func minimumTime(time []int, totalTrips int) int64 {
	// Find the maximum time taken by any single bus for one trip.
	// This helps in establishing a tighter upper bound for binary search.
	var maxTimePerTrip int64 = 0
	for _, t := range time {
		if