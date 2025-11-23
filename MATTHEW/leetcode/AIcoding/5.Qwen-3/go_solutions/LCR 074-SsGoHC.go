package main


func merge(intervals []Interval) []Interval {
	if len(intervals) == 0 {
		return intervals
	}
	// Sort intervals based on start time
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i].Start < intervals[j].Start
	})
	result := []Interval{intervals[0]}
	for i := 1; i < len(intervals); i++ {
		last := result[len(result)-1]
		if intervals[i].Start <= last.End {
			// Overlapping intervals, merge them
			if intervals[i].End > last.End {
				result[len(result)-1].End = intervals[i].End
			}
		} else {
			result = append(result, intervals[i])
		}
	}
	return result
}