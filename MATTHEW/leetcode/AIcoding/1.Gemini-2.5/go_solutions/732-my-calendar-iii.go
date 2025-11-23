type MyCalendarThree struct {
	timeline map[int]int
}

func Constructor() MyCalendarThree {
	return MyCalendarThree{
		timeline: make(map[int]int),
	}
}

func (this *MyCalendarThree) Book(start int, end int) int {
	this.timeline[start]++
	this.timeline[end]--

	keys := make([]int, 0, len(this.timeline))
	for k := range this.timeline {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	currentOverlap := 0
	maxOverlap := 0

	for _, k := range keys {
		currentOverlap += this.timeline[k]
		if currentOverlap > maxOverlap {
			maxOverlap = currentOverlap
		}
	}

	return maxOverlap
}

/**
 * Your MyCalendarThree object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 :=