package main

func findMinDifference(timePoints []string) int {
    n := len(timePoints)
    times := make([]int, n)
    for i := 0; i < n; i++ {
        h, _ := strconv.Atoi(timePoints[i][:2])
        m, _ := strconv.Atoi(timePoints[i][3:])
        times[i] = h*60 + m
    }
    sort.Ints(times)
    minDiff := math.MaxInt32
    for i := 0; i < n; i++ {
        diff := times[(i+1)%n] - times[i]
        if diff > 720 {
            diff -= 1440
        }
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}