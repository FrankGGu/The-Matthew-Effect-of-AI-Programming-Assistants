type MyCalendarTwo struct {
    events [][]int
    overlaps [][]int
}

func Constructor() MyCalendarTwo {
    return MyCalendarTwo{
        events: make([][]int, 0),
        overlaps: make([][]int, 0),
    }
}

func (this *MyCalendarTwo) Book(start int, end int) bool {
    for _, overlap := range this.overlaps {
        if start < overlap[1] && end > overlap[0] {
            return false
        }
    }
    for _, event := range this.events {
        s := max(start, event[0])
        e := min(end, event[1])
        if s < e {
            this.overlaps = append(this.overlaps, []int{s, e})
        }
    }
    this.events = append(this.events, []int{start, end})
    return true
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}