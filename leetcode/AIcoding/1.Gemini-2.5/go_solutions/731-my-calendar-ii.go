type MyCalendarTwo struct {
	calendar [][]int // Stores all successfully booked intervals
	overlaps [][]int // Stores intervals that are double-booked (or more)
}

func Constructor() MyCalendarTwo {
	return MyCalendarTwo{
		calendar: make([][]int