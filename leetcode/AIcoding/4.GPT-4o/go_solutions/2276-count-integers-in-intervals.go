type Interval struct {
    start int
    end   int
}

type CountIntervals struct {
    intervals []Interval
}

func Constructor() CountIntervals {
    return CountIntervals{intervals: []Interval{}}
}

func (this *CountIntervals) Add(interval Interval) {
    newIntervals := []Interval{}
    merged := Interval{start: interval.start, end: interval.end}

    for _, iv := range this.intervals {
        if iv.end < merged.start {
            newIntervals = append(newIntervals, iv)
        } else if iv.start > merged.end {
            newIntervals = append(newIntervals, iv)
        } else {
            merged.start = min(merged.start, iv.start)
            merged.end = max(merged.end, iv.end)
        }
    }

    newIntervals = append(newIntervals, merged)
    this.intervals = newIntervals
}

func (this *CountIntervals) Count() int {
    count := 0
    for _, iv := range this.intervals {
        count += iv.end - iv.start + 1
    }
    return count
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