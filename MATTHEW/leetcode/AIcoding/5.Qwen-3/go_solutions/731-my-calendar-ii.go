package main

type MyCalendarTwo struct {
    bookings []int
}

func Constructor() MyCalendarTwo {
    return MyCalendarTwo{}
}

func (this *MyCalendarTwo) book(start int, end int) bool {
    for i := 0; i < len(this.bookings); i += 2 {
        s1, e1 := this.bookings[i], this.bookings[i+1]
        if start < e1 && end > s1 {
            return false
        }
    }
    for i := 0; i < len(this.bookings); i += 2 {
        s1, e1 := this.bookings[i], this.bookings[i+1]
        if start < e1 && end > s1 {
            this.bookings = append(this.bookings, start, end)
            return true
        }
    }
    this.bookings = append(this.bookings, start, end)
    return true
}