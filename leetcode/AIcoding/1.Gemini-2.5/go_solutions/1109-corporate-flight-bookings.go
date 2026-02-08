func corpFlightBookings(bookings [][]int, n int) []int {
	ans := make([]int, n)

	for _, booking := range bookings {
		first := booking[0]
		last := booking[1]
		seats := booking[2]

		// Convert 1-indexed to 0-indexed
		startIndex := first - 1
		endIndex := last - 1

		// Add seats at the start of the booking range
		ans[startIndex] += seats

		// Subtract seats one position after the end of the booking range
		// to cancel out the effect for subsequent flights
		if endIndex+1 < n {
			ans[endIndex+1] -= seats
		}
	}

	// Calculate prefix sums to get the total seats for each flight
	for i := 1; i < n; i++ {
		ans[i] += ans[i-1]
	}

	return ans
}