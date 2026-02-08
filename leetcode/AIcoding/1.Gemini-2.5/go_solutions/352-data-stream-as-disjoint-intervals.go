import (
	"sort"
)

type SummaryRanges struct {
	intervals [][]int
}

func Constructor() SummaryRanges {
	return SummaryRanges{
		intervals: [][]int{},
	}
}

func (this *SummaryRanges) AddNum(val int) {
	idx := sort.Search(len(this.intervals), func(i int) bool {
		return this.intervals[i][0] > val
	})

	if idx > 0 && this.intervals[idx-1][1] >= val {
		return
	}

	canMergePrev := false
	if idx > 0 && this.intervals[idx-1][1] == val-1 {
		canMergePrev = true
	}

	canMergeNext := false
	if idx < len(this.intervals) && this.intervals[idx][0] == val+1 {
		canMergeNext = true
	}

	if canMergePrev && canMergeNext {
		this.intervals[idx-1][1] = this.intervals[idx][1]
		this.intervals = append(this.intervals[:idx], this.intervals[idx+1:]...)
	} else if canMergePrev {
		this.intervals[idx-1][1] = val
	} else if canMergeNext {
		this.intervals[idx][0] = val
	} else {
		newInterval := []int{val, val}
		this.intervals = append(this.intervals, nil)
		copy(this.intervals[idx+1:], this.intervals[idx:])
		this.intervals[idx] = newInterval
	}
}

func (this *SummaryRanges) GetIntervals() [][]int {
	return this.intervals
}