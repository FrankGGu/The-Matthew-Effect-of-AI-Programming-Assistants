import (
	"sort"
	"strconv"
	"strings"
)

func findMinDifference(timePoints []string) int {
	minutes := make([]int, len(timePoints))
	for i, timePoint := range timePoints {
		parts := strings.Split(timePoint, ":")
		hour, _ := strconv.Atoi(parts[0])
		minute, _ := strconv.Atoi(parts[1])
		minutes[i] = hour*60 + minute
	}

	sort.Ints(minutes)

	minDiff := 1440
	for i := 1; i < len(minutes); i++ {
		diff := minutes[i] - minutes[i-1]
		if diff < minDiff {
			minDiff = diff
		}
	}

	lastDiff := minutes[0] + 1440 - minutes[len(minutes)-1]
	if lastDiff < minDiff {
		minDiff = lastDiff
	}

	return minDiff
}