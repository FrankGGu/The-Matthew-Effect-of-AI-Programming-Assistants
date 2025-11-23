package main

type MyCalendarThree struct {
    events []int
}

func Constructor() MyCalendarThree {
    return MyCalendarThree{
        events: make([]int, 0),
    }
}

func (this *MyCalendarThree) Book(start int, end int) bool {
    this.events = append(this.events, start)
    this.events = append(this.events, end)
    sort.Ints(this.events)

    maxCount := 0
    currentCount := 0

    for i := 0; i < len(this.events); i += 2 {
        currentCount++
        if i+1 < len(this.events) && this.events[i+1] == this.events[i] {
            i++
        }
        if currentCount > maxCount {
            maxCount = currentCount
        }
    }

    return true
}