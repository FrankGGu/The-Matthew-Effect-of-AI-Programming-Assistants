type RangeModule struct {
	intervals [][]int
}

func Constructor() RangeModule {
	return RangeModule{intervals: [][]int{}}
}

func (this *RangeModule) AddRange(left int, right int) {
	newInterval := []int{left, right}
	newIntervals := [][]int{}
	i := 0
	for i < len(this.intervals) && this.intervals[i][1] < left {
		newIntervals = append(newIntervals, this.intervals[i])
		i++
	}
	for i < len(this.intervals) && this.intervals[i][0] <= right {
		newInterval[0] = min(newInterval[0], this.intervals[i][0])
		newInterval[1] = max(newInterval[1], this.intervals[i][1])
		i++
	}
	newIntervals = append(newIntervals, newInterval)
	for i < len(this.intervals) {
		newIntervals = append(newIntervals, this.intervals[i])
		i++
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