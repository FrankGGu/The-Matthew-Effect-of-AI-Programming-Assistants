type Interval struct {
    Start int
    End   int
}

type CountIntervals struct {
    intervals []Interval
    count     int
}

func Constructor() CountIntervals {
    return CountIntervals{}
}

func (this *CountIntervals) Add(left int, right int) {
    newInterval := Interval{left, right}
    merged := []Interval{}
    i := 0
    n := len(this.intervals)
    for i < n && this.intervals[i].End < left {
        merged = append(merged, this.intervals[i])
        i++
    }
    for i < n && this.intervals[i].Start <= right {
        newInterval.Start = min(newInterval.Start, this.intervals[i].Start)
        newInterval.End = max(newInterval.End, this.intervals[i].End)
        i++
    }
    merged = append(merged, newInterval)
    for i < n {
        merged = append(merged, this.intervals[i])
        i++
    }
    this.intervals = merged
    this.count = 0
    for _, interval := range this.intervals {
        this.count += interval.End - interval.Start + 1
    }
}

func (this *CountIntervals) Count() int {
    return this.count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}