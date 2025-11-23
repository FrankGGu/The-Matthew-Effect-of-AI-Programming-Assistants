func corpFlightBookings(bookings [][]int, n int) []int {
	ans := make([]int, n)
	for _, booking := range bookings {
		first := booking[0] - 1
		last := booking[1] - 1
		seats := booking[2]
		ans[first] += seats
		if last+1 < n {
			ans[last+1] -= seats
		}
	}
	for i := 1; i < n; i++ {
		ans[i] += ans[i-1]
	}
	return ans
}