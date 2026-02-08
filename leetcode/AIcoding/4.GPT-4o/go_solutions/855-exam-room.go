type ExamRoom struct {
    n      int
    seats  []int
}

func Constructor(n int) ExamRoom {
    return ExamRoom{n: n, seats: []int{}}
}

func (this *ExamRoom) Seat() int {
    if len(this.seats) == 0 {
        this.seats = append(this.seats, 0)
        return 0
    }
    maxDist, seat := 0, 0
    last := -1
    for i, s := range this.seats {
        dist := 0
        if last == -1 {
            dist = s
        } else {
            dist = (s - last) / 2
        }
        if dist > maxDist {
            maxDist = dist
            seat = last + dist
        }
        last = s
    }
    if this.n-1-last > maxDist {
        seat = this.n - 1
    }
    this.seats = append(this.seats, seat)
    sort.Ints(this.seats)
    return seat
}

func (this *ExamRoom) Leave(seat int) {
    for i := 0; i < len(this.seats); i++ {
        if this.seats[i] == seat {
            this.seats = append(this.seats[:i], this.seats[i+1:]...)
            break
        }
    }
}