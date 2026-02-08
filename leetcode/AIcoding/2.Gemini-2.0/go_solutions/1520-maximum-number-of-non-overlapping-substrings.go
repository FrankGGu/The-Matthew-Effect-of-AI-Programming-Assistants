import (
	"sort"
)

func maxNonOverlapping(s string) []string {
	left := make([]int, 26)
	right := make([]int, 26)
	for i := 0; i < 26; i++ {
		left[i] = -1
		right[i] = -1
	}

	for i := 0; i < len(s); i++ {
		c := s[i] - 'a'
		if left[c] == -1 {
			left[c] = i
		}
		right[c] = i
	}

	intervals := [][]int{}
	for i := 0; i < len(s); i++ {
		start := i
		end := right[s[i]-'a']
		valid := true
		for j := start; j <= end; j++ {
			if left[s[j]-'a'] < start {
				valid = false
				break
			}
			end = max(end, right[s[j]-'a'])
		}
		if valid {
			intervals = append(intervals, []int{start, end})
		}
	}

	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][1] < intervals[j][1]
	})

	result := []string{}
	last := -1
	for _, interval := range intervals {
		if interval[0] > last {
			result = append(result, s[interval[0]:interval[1]+1])
			last = interval[1]
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