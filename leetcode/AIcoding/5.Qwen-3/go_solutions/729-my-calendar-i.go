package main

type MyCalendar struct {
    events []int
}

func Constructor() MyCalendar {
    return MyCalendar{
        events: make([]int, 0),
    }
}

func (this *MyCalendar) book(start int, end int) bool {
    for i := 0; i < len(this.events); i += 2 {
        if start < this.events[i+1] && end > this.events[i] {
            return false
        }
    }
    this.events = append(this.events, start, end)
    return true
}