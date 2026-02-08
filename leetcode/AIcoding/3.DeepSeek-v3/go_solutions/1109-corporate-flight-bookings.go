func corpFlightBookings(bookings [][]int, n int) []int {
    res := make([]int, n)
    for _, booking := range bookings {
        first, last, seats := booking[0], booking[1], booking[2]
        res[first-1] += seats
        if last < n {
            res[last] -= seats
        }
    }
    for i := 1; i < n; i++ {
        res[i] += res[i-1]
    }
    return res
}