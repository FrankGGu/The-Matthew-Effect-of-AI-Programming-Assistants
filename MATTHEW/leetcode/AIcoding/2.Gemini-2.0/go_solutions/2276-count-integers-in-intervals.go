type Interval struct {
    Start, End int
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
    i := 0
    for i < len(this.intervals) {
        if newInterval.End < this.intervals[i].Start {
            break
        } else if newInterval.Start > this.intervals[i].End {
            i++
            continue
        } else {
            newInterval.Start = min(newInterval.Start, this.intervals[i].Start)
            newInterval.End = max(newInterval.End, this.intervals[i].End)
            this.count -= (this.intervals[i].End - this.intervals[i].Start + 1)
            this.intervals = append(this.intervals[:i], this.intervals[i+1:]...)
        }
    }
    this.intervals = append(this.intervals[:i], append([]Interval{newInterval}, this.intervals[i:]...)...)
    this.count += (newInterval.End - newInterval.Start + 1)
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