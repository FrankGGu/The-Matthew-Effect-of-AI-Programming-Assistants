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
        old