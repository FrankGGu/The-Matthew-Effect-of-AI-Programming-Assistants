import (
	"sort"
)

func maxNonOverlapping(s string) []string {
	n := len(s)
	left := make([]int, 26)
	right := make([]int, 26)
	for i := 0; i < 26; i++ {
		left[i] = n
		right[i] = -1
	}
	for i := 0; i < n; i++ {
		c := s[i] - 'a'
		left[c] = min(left[c], i)
		right[c] = max(right[c], i)
	}

	intervals := []interval{}
	for i := 0; i < 26; i++ {
		if left[i] < n {
			start := left[i]
			end := right[i]
			j := start
			valid := true
			for ; j <= end; j++ {
				c := s[j] - 'a'
				if left[c] < start {
					valid = false
					break
				}
				end = max(end, right[c])
			}
			if valid {
				intervals = append(intervals, interval{start: start, end: end})
			}
		}
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i].end < intervals[j].end
	})

	result := []string{}
	lastEnd := -1
	for _, interval := range intervals {
		if interval.start > lastEnd {
			result = append(result, s[interval.start:interval.end+1])
			lastEnd = interval.end
		}
	}

	return result
}

type interval struct {
	start int
	end   int
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