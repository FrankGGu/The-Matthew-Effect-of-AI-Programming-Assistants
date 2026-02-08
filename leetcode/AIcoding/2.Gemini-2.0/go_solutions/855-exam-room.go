import "container/heap"

type Interval struct {
	start, end, length int
}

type Intervals []Interval

func (h Intervals) Len() int           { return len(h) }
func (h Intervals) Less(i, j int) bool { return h[i].length > h[j].length }
func (h Intervals) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *Intervals) Push(x interface{}) {
	*h = append(*h, x.(Interval))
}

func (h *Intervals) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

type ExamRoom struct {
	n         int
	intervals Intervals
	seats     map[int]bool
}

func Constructor(n int) ExamRoom {
	er := ExamRoom{
		n:         n,
		intervals: make(Intervals, 0),
		seats:     make(map[int]bool),
	}
	heap.Init(&er.intervals)
	heap.Push(&er.intervals, Interval{start: -1, end: n, length: n - 1})
	return er
}

func (this *ExamRoom) Seat() int {
	interval := heap.Pop(&this.intervals).(Interval)
	start, end := interval.start, interval.end
	var seat int
	if start == -1 {
		seat = 0
	} else if end == this.n {
		seat = this.n - 1
	} else {
		seat = (start + end) / 2
	}

	this.seats[seat] = true

	if seat > start+1 {
		heap.Push(&this.intervals, Interval{start: start, end: seat, length: (seat - start - 1) / 2})
	}
	if end > seat+1 {
		heap.Push(&this.intervals, Interval{start: seat, end: end, length: (end - seat - 1) / 2})
	}

	return seat
}

func (this *ExamRoom) Leave(p int) {
	delete(this.seats, p)

	var left, right int
	for _, interval := range this.intervals {
		if interval.end == p {
			left = interval.start
			break
		}
	}
	for _, interval := range this.intervals {
		if interval.start == p {
			right = interval.end
			break
		}
	}

	newInterval := Interval{start: left, end: right, length: (right - left - 1) / 2}

	newIntervals := make(Intervals, 0)
	for _, interval := range this.intervals {
		if interval.end != p && interval.start != p {
			newIntervals = append(newIntervals, interval)
		}
	}

	heap.Init(&newIntervals)
	heap.Push(&newIntervals, newInterval)
	this.intervals = newIntervals
}