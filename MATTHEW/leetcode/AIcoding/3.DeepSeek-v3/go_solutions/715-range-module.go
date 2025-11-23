type RangeModule struct {
    intervals [][]int
}

func Constructor() RangeModule {
    return RangeModule{intervals: [][]int{}}
}

func (this *RangeModule) AddRange(left int, right int) {
    newIntervals := [][]int{}
    inserted := false
    for _, interval := range this.intervals {
        if interval[1] < left {
            newIntervals = append(newIntervals, interval)
        } else if interval[0] > right {
            if !inserted {
                newIntervals = append(newIntervals, []int{left, right})
                inserted = true
            }
            newIntervals = append(newIntervals, interval)
        } else {
            left = min(left, interval[0])
            right = max(right, interval[1])
        }
    }
    if !inserted {
        newIntervals = append(newIntervals, []int{left, right})
    }
    this.intervals = newIntervals
}

func (this *RangeModule) QueryRange(left int, right int) bool {
    for _, interval := range this.intervals {
        if interval[0] <= left && interval[1] >= right {
            return true
        }
    }
    return false
}

func (this *RangeModule) RemoveRange(left int, right int) {
    newIntervals := [][]int{}
    for _, interval := range this.intervals {
        if interval[1] < left || interval[0] > right {
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