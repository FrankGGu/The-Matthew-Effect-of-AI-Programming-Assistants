package main

type MyCalendar struct {
    events []int
}

func Constructor() MyCalendar {
    return MyCalendar{
        events: make([]int, 0),
    }
}

func (this *MyCalendar) Book(start int, end int) bool {
    for i := 0; i < len(this.events); i += 2 {
        if start < this.events[i+1] && end > this.events[i] {
            return false
        }
    }
    this.events = append(this.events, start)
    this.events = append(this.events, end)
    return true
}