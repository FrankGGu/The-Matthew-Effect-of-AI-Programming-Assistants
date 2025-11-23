package main

type SummaryRanges struct {
    intervals [][]int
}

func Constructor() SummaryRanges {
    return SummaryRanges{
        intervals: make([][]int, 0),
    }
}

func (this *SummaryRanges) addNum(value int) {
    newInterval := []int{value, value}
    merged := make([][]int, 0)
    i := 0
    n := len(this.intervals)
    for i < n && this.intervals[i][1] < value-1 {
        merged = append(merged, this.intervals[i])
        i++
    }
    for i < n && this.intervals[i][0] <= value+1 {
        newInterval[0] = min(newInterval[0], this.intervals[i][0])
        newInterval[1] = max(newInterval[1], this.intervals[i][1])
        i++
    }
    merged = append(merged, newInterval)
    for i < n {
        merged = append(merged, this.intervals[i])
        i++
    }
    this.intervals = merged
}

func (this *SummaryRanges) getIntervals() [][]int {
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