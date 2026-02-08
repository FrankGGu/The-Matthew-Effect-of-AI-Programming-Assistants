import (
	"sort"
	"strconv"
	"strings"
)

func findMinDifference(timePoints []string) int {
	minutes := make([]int, len(timePoints))
	for i, tp := range timePoints {
		parts := strings.Split(tp, ":")
		h, _ := strconv.Atoi(parts[0])
		m, _ := strconv.Atoi(parts[1])
		minutes[i] = h*60 + m
	}

	sort.Ints(minutes)

	minDiff := 1440 // Max possible difference is 24 hours * 60 minutes = 1440

	for i := 1; i < len(minutes); i++ {
		diff := minutes[i] - minutes[i-1]
		if diff < minDiff {
			minDiff = diff
		}
	}

	// Consider the wrap-around case: difference between the last and first time point across midnight
	wrapAroundDiff := (minutes[0] + 1440) - minutes[len(minutes)-1]
	if wrapAroundDiff < minDiff {
		minDiff = wrapAroundDiff
	}

	return minDiff
}