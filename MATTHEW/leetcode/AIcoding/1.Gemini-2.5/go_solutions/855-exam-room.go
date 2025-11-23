package examroom

type ExamRoom struct {
	N     int
	Seats []int
}

func Constructor(n int) ExamRoom {
	return ExamRoom{
		N:     n,
		Seats: []int{},
	}
}

func (this *ExamRoom) Seat()