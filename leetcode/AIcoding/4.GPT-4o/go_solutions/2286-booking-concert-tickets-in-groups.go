type Booking struct {
    total      int
    booked     int
    reservations map[int]int
}

func Constructor(n int) Booking {
    return Booking{
        total:      n,
        booked:     0,
        reservations: make(map[int]int),
    }
}

func (this *Booking) Reserve(seatCount int) int {
    if this.booked + seatCount > this.total {
        return -1
    }

    start := 1
    for start <= this.total {
        if this.canReserve(start, seatCount) {
            this.booked += seatCount
            for i := 0; i < seatCount; i++ {
                this.reservations[start+i]++
            }
            return start
        }
        start++
    }
    return -1
}

func (this *Booking) canReserve(start, seatCount int) bool {
    for i := 0; i < seatCount; i++ {
        if this.reservations[start+i] > 0 {
            return false
        }
    }
    return true
}