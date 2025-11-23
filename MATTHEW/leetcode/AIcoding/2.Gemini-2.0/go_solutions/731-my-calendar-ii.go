type MyCalendarTwo struct {
	calendar []int
	overlaps []int
}

func Constructor() MyCalendarTwo {
	return MyCalendarTwo{
		calendar: []int{},
		overlaps: []int{},
	}
}

func (this *MyCalendarTwo) Book(start int, end int) bool {
	for i := 0; i < len(this.overlaps); i += 2 {
		s := this.overlaps[i]
		e := this.overlaps[i+1]
		if start < e && end > s {
			return false
		}
	}

	for i := 0; i < len(this.calendar); i += 2 {
		s := this.calendar[i]
		e := this.calendar[i+1]
		if start < e && end > s {
			this.overlaps = append(this.overlaps, max(start, s), min(end, e))
		}
	}

	this.calendar = append(this.calendar, start, end)
	return true
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}