type SummaryRanges struct {
    intervals [][]int
}

func Constructor() SummaryRanges {
    return SummaryRanges{intervals: [][]int{}}
}

func (this *SummaryRanges) AddNum(value int)  {
    newInterval := []int{value, value}
    merged := [][]int{}
    inserted := false
    for _, interval := range this.intervals {
        if interval[1] < newInterval[0]-1 {
            merged = append(merged, interval)
        } else if interval[0] > newInterval[1]+1 {
            if !inserted {
                merged = append(merged, newInterval)
                inserted = true
            }
            merged = append(merged, interval)
        } else {
            newInterval[0] = min(newInterval[0], interval[0])
            newInterval[1] = max(newInterval[1], interval[1])
        }
    }
    if !inserted {
        merged = append(merged, newInterval)
    }
    this.intervals = merged
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