package main


func merge(intervals []Interval) []Interval {
	if len(intervals) == 0 {
		return intervals
	}
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i].Start < intervals[j].Start
	})
	result := []Interval{intervals[0]}
	for i := 1; i < len(intervals); i++ {
		last := result[len(result)-1]
		if intervals[i].Start <= last.End {
			result[len(result)-1].End = max(last.End, intervals[i].End)
		} else {
			result = append(result, intervals[i])
		}
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}