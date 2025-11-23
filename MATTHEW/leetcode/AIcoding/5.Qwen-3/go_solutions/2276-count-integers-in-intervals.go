package main

type Interval struct {
	start int
	end   int
}

type CountIntegersInIntervals struct {
	intervals []Interval
}

func Constructor() CountIntegersInIntervals {
	return CountIntegersInIntervals{}
}

func (this *CountIntegersInIntervals) add(start int, end int) {
	this.intervals = append(this.intervals, Interval{start, end})
}

func (this *CountIntegersInIntervals) count() int {
	if len(this.intervals) == 0 {
		return 0
	}

	// Sort intervals by start time
	for i := 0; i < len(this.intervals); i++ {
		for j := i + 1; j < len(this.intervals); j++ {
			if this.intervals[i].start > this.intervals[j].start {
				this.intervals[i], this.intervals[j] = this.intervals[j], this.intervals[i]
			}
		}
	}

	// Merge overlapping intervals
	merged := []Interval{}
	for _, interval := range this.intervals {
		if len(merged) == 0 || merged[len(merged)-1].end < interval.start-1 {
			merged = append(merged, interval)
		} else {
			merged[len(merged)-1].end = max(merged[len(merged)-1].end, interval.end)
		}
	}

	// Count total integers
	count := 0
	for _, interval := range merged {
		count += interval.end - interval.start + 1
	}

	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}