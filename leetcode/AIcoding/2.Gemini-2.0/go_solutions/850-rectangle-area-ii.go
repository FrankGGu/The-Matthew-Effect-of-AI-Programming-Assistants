import "sort"

func rectangleArea(rectangles [][]int) int {
	const MOD = 1000000007
	xSet := make(map[int]bool)
	for _, rect := range rectangles {
		xSet[rect[0]] = true
		xSet[rect[2]] = true
	}
	xValues := make([]int, 0, len(xSet))
	for x := range xSet {
		xValues = append(xValues, x)
	}
	sort.Ints(xValues)
	xSegments := make([]int, 0, len(xValues)-1)
	for i := 1; i < len(xValues); i++ {
		xSegments = append(xSegments, xValues[i]-xValues[i-1])
	}
	segments := make([]Segment, 0, len(rectangles))
	for _, rect := range rectangles {
		segments = append(segments, Segment{rect[1], rect[3], rect[0], rect[2]})
	}
	sort.Slice(segments, func(i, j int) bool {
		return segments[i].y1 < segments[j].y1
	})
	active := []Interval{}
	totalArea := 0
	prevY := 0
	for i := 0; i < len(segments); i++ {
		curY := segments[i].y1
		totalArea = (totalArea + coverLength(active) * (curY - prevY)) % MOD
		for j := i; j < len(segments) && segments[j].y1 == curY; j++ {
			active = addInterval(active, segments[j].x1, segments[j].x2)
		}
		for k := 0; k < len(segments) && segments[k].y2 <= curY; k++ {
			segments = append(segments[:k], segments[k+1:]...)
			k--
		}
		i--
		prevY = curY
	}
	return totalArea
}

type Segment struct {
	y1, y2, x1, x2 int
}

type Interval struct {
	start, end int
}

func addInterval(intervals []Interval, start, end int) []Interval {
	newInterval := Interval{start, end}
	res := make([]Interval, 0)
	for _, interval := range intervals {
		if interval.end < newInterval.start {
			res = append(res, interval)
		} else if interval.start > newInterval.end {
			res = append(res, newInterval)
			newInterval = interval
		} else {
			newInterval.start = min(interval.start, newInterval.start)
			newInterval.end = max(interval.end, newInterval.end)
		}
	}
	res = append(res, newInterval)
	return res
}

func coverLength(intervals []Interval) int {
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i].start < intervals[j].start
	})
	merged := make([]Interval, 0)
	for _, interval := range intervals {
		if len(merged) == 0 || interval.start > merged[len(merged)-1].end {
			merged = append(merged, interval)
		} else {
			merged[len(merged)-1].end = max(merged[len(merged)-1].end, interval.end)
		}
	}
	totalLength := 0
	for _, interval := range merged {
		totalLength += interval.end - interval.start
	}
	return totalLength
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