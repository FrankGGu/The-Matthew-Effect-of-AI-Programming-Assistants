type MyCalendar struct {
    events [][]int
}

func Constructor() MyCalendar {
    return MyCalendar{events: make([][]int, 0)}
}

func (this *MyCalendar) Book(start int, end int) bool {
    for _, event := range this.events {
        if start < event[1] && end > event[0] {
            return false
        }
    }
    this.events = append(this.events, []int{start, end})
    return true
}

/**
 * Your MyCalendar object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Book(start,end);
 */