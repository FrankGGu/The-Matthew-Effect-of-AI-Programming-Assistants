type SummaryRanges struct {
    intervals [][]int
}

func Constructor() SummaryRanges {
    return SummaryRanges{intervals: [][]int{}}
}

func (this *SummaryRanges) AddNum(val int) {
    left, right := 0, len(this.intervals)-1
    for left <= right {
        mid := left + (right-left)/2
        interval := this.intervals[mid]
        if interval[0] <= val && val <= interval[1] {
            return
        } else if interval[0] > val {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    pos := left
    merged := false
    if pos > 0 && this.intervals[pos-1][1]+1 == val {
        this.intervals[pos-1][1] = val
        merged = true
    }
    if pos < len(this.intervals) && this.intervals[pos][0]-1 == val {
        this.intervals[pos][0] = val
        merged = true
    }
    if pos > 0 && pos < len(this.intervals) && this.intervals[pos-1][1] == this.intervals[pos][0] {
        this.intervals[pos-1][1] = this.intervals[pos][1]
        this.intervals = append(this.intervals[:pos], this.intervals[pos+1:]...)
    } else if !merged {
        newInterval := []int{val, val}
        this.intervals = append(this.intervals[:pos], append([][]int{newInterval}, this.intervals[pos:]...)...)
    }
}

func (this *SummaryRanges) GetIntervals() [][]int {
    return this.intervals
}