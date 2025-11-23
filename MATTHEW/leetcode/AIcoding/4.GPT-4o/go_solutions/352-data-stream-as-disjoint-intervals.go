type SummaryRanges struct {
    intervals [][]int
}

func Constructor() SummaryRanges {
    return SummaryRanges{intervals: [][]int{}}
}

func (this *SummaryRanges) AddNum(value int) {
    newInterval := []int{value, value}
    i := 0
    for i < len(this.intervals) {
        if this.intervals[i][1] < value-1 {
            i++
        } else if this.intervals[i][0] > value+1 {
            break
        } else {
            newInterval[0] = min(newInterval[0], this.intervals[i][0])
            newInterval[1] = max(newInterval[1], this.intervals[i][1])
            break
        }
    }
    this.intervals = append(this.intervals[:i], append([][]int{newInterval}, this.intervals[i:]...)...)
    for i > 0 && this.intervals[i-1][1] >= this.intervals[i][0] {
        this.intervals[i-1][1] = max(this.intervals[i-1][1], this.intervals[i][1])
        this.intervals = append(this.intervals[:i], this.intervals[i+1:]...)
        i--
    }
}

func (this *SummaryRanges) GetIntervals() [][]int {
    return this.intervals
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