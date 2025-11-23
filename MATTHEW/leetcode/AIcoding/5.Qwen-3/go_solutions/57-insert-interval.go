package main

type Interval struct {
	Start int
	End   int
}

func insert(intervals []*Interval, newInterval *Interval) []*Interval {
	result := []*Interval{}
	i := 0
	n := len(intervals)

	for i < n && intervals[i].End < newInterval.Start {
		result = append(result, intervals[i])
		i++
	}

	for i < n && intervals[i].Start <= newInterval.End {
		newInterval.Start = min(newInterval.Start, intervals[i].Start)
		newInterval.End = max(newInterval.End, intervals[i].End)
		i++
	}

	result = append(result, newInterval)

	for i < n {
		result = append(result, intervals[i])
		i++
	}

	return result
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