type RangeModule struct {
    intervals [][]int
}

func Constructor() RangeModule {
    return RangeModule{intervals: [][]int{}}
}

func (this *RangeModule) AddRange(left int, right int) {
    newInterval := []int{left, right}
    i := 0
    for i < len(this.intervals) && this.intervals[i][1] < left {
        i++
    }
    for i < len(this.intervals) && this.intervals[i][0] <= right {
        newInterval[0] = min(newInterval[0], this.intervals[i][0])
        newInterval[1] = max(newInterval[1], this.intervals[i][1])
        i++
    }
    this.intervals = append(this.intervals[:i-len(this.intervals)], newInterval)
    this.intervals = append(this.intervals, this.intervals[i:]...)
}

func (this *RangeModule) QueryRange(left int, right int) bool {
    i := 0
    for i < len(this.intervals) && this.intervals[i][1] < left {
        i++
    }
    return i < len(this.intervals) && this.intervals[i][0] <= left && this.intervals[i][1] >= right
}

func (this *RangeModule) RemoveRange(left int, right int) {
    newIntervals := [][]int{}
    for _, interval := range this.intervals {
        if interval[1] <= left || interval[0] >= right {
            newIntervals = append(newIntervals, interval)
        } else {
            if interval[0] < left {
                newIntervals = append(newIntervals, []int{interval[0], left})
            }
            if interval[1] > right {
                newIntervals = append(newIntervals, []int{right, interval[1]})
            }
        }
    }
    this.intervals = newIntervals
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