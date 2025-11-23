type ExamRoom struct {
    seats []int
    n     int
}

func Constructor(n int) ExamRoom {
    return ExamRoom{seats: make([]int, 0), n: n}
}

func (this *ExamRoom) Seat() int {
    if len(this.seats) == 0 {
        this.seats = append(this.seats, 0)
        return 0
    }
    maxDist := this.seats[0]
    pos := 0
    for i := 1; i < len(this.seats); i++ {
        dist := (this.seats[i] - this.seats[i-1]) / 2
        if dist > maxDist {
            maxDist = dist
            pos = this.seats[i-1] + dist
        }
    }
    lastDist := this.n - 1 - this.seats[len(this.seats)-1]
    if lastDist > maxDist {
        pos = this.n - 1
        maxDist = lastDist
    }
    idx := sort.SearchInts(this.seats, pos)
    this.seats = append(this.seats, 0)
    copy(this.seats[idx+1:], this.seats[idx:])
    this.seats[idx] = pos
    return pos
}

func (this *ExamRoom) Leave(p int) {
    idx := sort.SearchInts(this.seats, p)
    this.seats = append(this.seats[:idx], this.seats[idx+1:]...)
}