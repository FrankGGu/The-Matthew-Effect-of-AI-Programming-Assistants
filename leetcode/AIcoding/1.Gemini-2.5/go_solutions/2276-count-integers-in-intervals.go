import (
	"math"
)

type CountIntervals struct {
	intervals  map[int]int
	totalCount int
}

func Constructor() CountIntervals {
	return CountIntervals{
		intervals:  make(map[int]int),
		totalCount: 0,
	}
}

func (this *CountIntervals) Add(left int, right int) {
	newLeft, newRight := left, right
	removedCount := 0

	var keysToRemove []int 

	for s, e := range this.intervals {
		if s <= newRight && e >= newLeft {
			removedCount += (e - s + 1)
			newLeft = int(math.Min(float64(newLeft), float64(s)))
			newRight = int(math.Max(float64(newRight), float64(e)))
			keysToRemove = append(keysToRemove, s)
		}
	}

	for _, s := range keysToRemove {
		delete(this.intervals, s)
	}

	this.intervals[newLeft] = newRight

	this.totalCount -= removedCount
	this.totalCount += (newRight - newLeft + 1)
}

func (this *CountIntervals) Count() int {
	return this.totalCount
}