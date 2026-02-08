type MyCalendar struct {
    events [][]int
}

func Constructor() MyCalendar {
    return MyCalendar{
        events: make([][]int, 0),
    }
}

func (this *MyCalendar) Book(start int, end int) bool {
    for _, event := range this.events {
        s := event[0]
        e := event[1]
        // Check for overlap: [start, end) and [s, e)
        // They overlap if start < e AND s < end
        if start < e && s < end {
            return false
        }
    }
    this.events = append(this.events, []int{start, end})
    return true
}