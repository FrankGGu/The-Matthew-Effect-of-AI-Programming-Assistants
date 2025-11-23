func findMinDifference(timePoints []string) int {
    minutes := make([]int, len(timePoints))
    for i, timeStr := range timePoints {
        hh := int(timeStr[0]-'0')*10 + int(timeStr[1]-'0')
        mm := int(timeStr[3]-'0')*10 + int(timeStr[4]-'0')
        minutes[i] = hh*60 + mm
    }
    sort.Ints(minutes)
    minDiff := 24*60
    for i := 1; i < len(minutes); i++ {
        diff := minutes[i] - minutes[i-1]
        if diff < minDiff {
            minDiff = diff
        }
    }
    circularDiff := minutes[0] + 24*60 - minutes[len(minutes)-1]
    if circularDiff < minDiff {
        minDiff = circularDiff
    }
    return minDiff
}