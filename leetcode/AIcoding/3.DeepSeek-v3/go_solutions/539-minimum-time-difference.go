func findMinDifference(timePoints []string) int {
    times := make([]int, len(timePoints))
    for i, t := range timePoints {
        hh := int(t[0]-'0')*10 + int(t[1]-'0')
        mm := int(t[3]-'0')*10 + int(t[4]-'0')
        times[i] = hh*60 + mm
    }
    sort.Ints(times)
    minDiff := 1440 + times[0] - times[len(times)-1]
    for i := 1; i < len(times); i++ {
        diff := times[i] - times[i-1]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}