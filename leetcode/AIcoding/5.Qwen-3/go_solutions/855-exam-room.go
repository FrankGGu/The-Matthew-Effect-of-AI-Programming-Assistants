package main

type ExamRoom struct {
    n int
    seats map[int]bool
    sorted []int
}

func Constructor(n int) ExamRoom {
    return ExamRoom{
        n:      n,
        seats:  make(map[int]bool),
        sorted: []int{},
    }
}

func (this *ExamRoom) Seat() int {
    if len(this.sorted) == 0 {
        this.seats[0] = true
        this.sorted = append(this.sorted, 0)
        return 0
    }

    maxDist := 0
    pos := 0

    // Check distance from start
    if this.sorted[0] > 0 {
        maxDist = this.sorted[0]
        pos = 0
    }

    // Check distances between seats
    for i := 1; i < len(this.sorted); i++ {
        prev := this.sorted[i-1]
        curr := this.sorted[i]
        dist := (curr - prev) / 2
        if dist > maxDist {
            maxDist = dist
            pos = prev + dist
        }
    }

    // Check distance from end
    if this.n-1 > this.sorted[len(this.sorted)-1] {
        dist := this.n - 1 - this.sorted[len(this.sorted)-1]
        if dist > maxDist {
            pos = this.n - 1
        }
    }

    this.seats[pos] = true
    insertIndex := 0
    for insertIndex < len(this.sorted) && this.sorted[insertIndex] < pos {
        insertIndex++
    }
    this.sorted = append(this.sorted, 0)
    copy(this.sorted[insertIndex+1:], this.sorted[insertIndex:])
    this.sorted[insertIndex] = pos
    return pos
}

func (this *ExamRoom) Leave(p int) {
    delete(this.seats, p)
    for i := 0; i < len(this.sorted); i++ {
        if this.sorted[i] == p {
            this.sorted = append(this.sorted[:i], this.sorted[i+1:]...)
            break
        }
    }
}