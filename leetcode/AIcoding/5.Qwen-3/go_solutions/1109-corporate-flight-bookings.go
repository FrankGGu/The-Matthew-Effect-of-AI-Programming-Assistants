package main

func corpFlightBookings(bookings [][]int, n int) []int {
    res := make([]int, n)
    for _, b := range bookings {
        start, end, seats := b[0]-1, b[1]-1, b[2]
        res[start] += seats
        if end+1 < n {
            res[end+1] -= seats
        }
    }
    for i := 1; i < n; i++ {
        res[i] += res[i-1]
    }
    return res
}