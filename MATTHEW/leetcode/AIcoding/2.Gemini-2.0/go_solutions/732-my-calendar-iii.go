type MyCalendarThree struct {
	events map[int]int
}

func Constructor() MyCalendarThree {
	return MyCalendarThree{
		events: make(map[int]int),
	}
}

func (this *MyCalendarThree) Book(start int, end int) int {
	this.events[start]++
	this.events[end]--

	overlap := 0
	maxOverlap := 0
	for i := 0; i <= 1000000000; i++ {
		overlap += this.events[i]
		if overlap > maxOverlap {
			maxOverlap = overlap
		}
		if i > end {
			break
		}
	}

	return maxOverlap
}