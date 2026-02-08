type SeatManager struct {
    availableSeats []int
}

func Constructor(n int) SeatManager {
    seats := make([]int, n)
    for i := 0; i < n; i++ {
        seats[i] = i + 1
    }
    return SeatManager{availableSeats: seats}
}

func (this *SeatManager) Reserve() int {
    seat := this.availableSeats[0]
    this.availableSeats = this.availableSeats[1:]
    return seat
}

func (this *SeatManager) Unreserve(seatNumber int) {
    this.availableSeats = append(this.availableSeats, seatNumber)
    sort.Ints(this.availableSeats)
}