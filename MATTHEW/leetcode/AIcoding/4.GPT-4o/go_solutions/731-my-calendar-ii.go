type MyCalendarTwo struct {
    events [][]int
}

func Constructor() MyCalendarTwo {
    return MyCalendarTwo{events: [][]int{}}
}

func (this *MyCalendarTwo) Book(start int, end int) bool {
    for _, event := range this.events {
        if start < event[1] && end > event[0] {
            if this.isOverlapping(event[0], event[1], start, end) {
                return false
            }
        }
    }
    this.events = append(this.events, []int{start, end})
    return true
}

func (this *MyCalendarTwo) isOverlapping(start1, end1, start2, end2 int) bool {
    return start1 < end2 && start2 < end1
}