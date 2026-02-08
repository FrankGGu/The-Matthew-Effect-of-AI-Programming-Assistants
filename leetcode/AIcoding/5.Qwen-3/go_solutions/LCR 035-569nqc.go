package main

func findMinDifference(timePoints []string) int {
    n := len(timePoints)
    for i := 0; i < n; i++ {
        timePoints[i] = timePoints[i][0:2] + ":" + timePoints[i][3:]
    }
    sort.Strings(timePoints)
    minDiff := 1440
    for i := 0; i < n; i++ {
        h1, _ := strconv.Atoi(timePoints[i][0:2])
        m1, _ := strconv.Atoi(timePoints[i][3:5])
        h2, _ := strconv.Atoi(timePoints[(i+1)%n][0:2])
        m2, _ := strconv.Atoi(timePoints[(i+1)%n][3:5])
        diff := (h2*60 + m2) - (h1*60 + m1)
        if diff < 0 {
            diff += 1440
        }
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}