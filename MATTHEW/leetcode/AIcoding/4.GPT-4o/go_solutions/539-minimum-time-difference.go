import (
    "sort"
)

func findMinDifference(timePoints []string) int {
    minutes := make([]int, len(timePoints))
    for i, time := range timePoints {
        h := int(time[0]-'0')*10 + int(time[1]-'0')
        m := int(time[3]-'0')*10 + int(time[4]-'0')
        minutes[i] = h*60 + m
    }

    sort.Ints(minutes)
    minDiff := 1440 // 24 * 60
    for i := 1; i < len(minutes); i++ {
        diff := minutes[i] - minutes[i-1]
        if diff < minDiff {
            minDiff = diff
        }
    }

    // Check the difference between the last and first time points
    wrapAroundDiff := (minutes[0] + 1440) - minutes[len(minutes)-1]
    if wrapAroundDiff < minDiff {
        minDiff = wrapAroundDiff
    }

    return minDiff
}