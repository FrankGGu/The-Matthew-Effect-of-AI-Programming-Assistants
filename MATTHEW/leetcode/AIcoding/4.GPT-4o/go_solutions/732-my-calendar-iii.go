type MyCalendarThree struct {
    events map[int]int
}

func Constructor() MyCalendarThree {
    return MyCalendarThree{events: make(map[int]int)}
}

func (this *MyCalendarThree) Book(start int, end int) int {
    this.events[start]++
    this.events[end]--

    maxOverlap := 0
    currentOverlap := 0

    for _, count := range this.events {
        currentOverlap += count
        if currentOverlap > maxOverlap {
            maxOverlap = currentOverlap
        }
    }

    return maxOverlap
}