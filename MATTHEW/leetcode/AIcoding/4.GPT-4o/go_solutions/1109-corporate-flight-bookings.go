func corpFlightBookings(bookings [][]int, n int) []int {
    result := make([]int, n)
    diff := make([]int, n+1)

    for _, booking := range bookings {
        start, end, seats := booking[0], booking[1], booking[2]
        diff[start-1] += seats
        diff[end] -= seats
    }

    for i := 1; i < n; i++ {
        diff[i] += diff[i-1]
    }

    for i := 0; i < n; i++ {
        result[i] = diff[i]
    }

    return result
}