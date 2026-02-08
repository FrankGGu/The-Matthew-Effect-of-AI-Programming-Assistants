type MyCalendarThree struct {
    events map[int]int
}

func Constructor() MyCalendarThree {
    return MyCalendarThree{events: make(map[int]int)}
}

func (this *MyCalendarThree) Book(start int, end int) int {
    this.events[start]++
    this.events[end]--

    keys := make([]int, 0, len(this.events))
    for k := range this.events {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    maxK, current := 0, 0
    for _, k := range keys {
        current += this.events[k]
        if current > maxK {
            maxK = current
        }
    }
    return maxK
}