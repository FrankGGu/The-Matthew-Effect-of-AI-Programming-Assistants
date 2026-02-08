package main

func maxValueAfterReverse(a []int) int {
    n := len(a)
    if n < 2 {
        return 0
    }

    maxVal := 0
    for i := 0; i < n-1; i++ {
        maxVal += abs(a[i] - a[i+1])
    }

    if n == 2 {
        return maxVal
    }

    maxDiff1 := 0
    minDiff1 := 0
    maxDiff2 := 0
    minDiff2 := 0

    for i := 0; i < n-1; i++ {
        diff1 := a[i] - a[i+1]
        diff2 := a[i+1] - a[i]
        if i > 0 {
            maxDiff1 = max(maxDiff1, a[i] - a[i-1])
            minDiff1 = min(minDiff1, a[i] - a[i-1])
            maxDiff2 = max(maxDiff2, a[i] - a[i-1])
            minDiff2 = min(minDiff2, a[i] - a[i-1])
        }
    }

    candidate1 := maxDiff1 - minDiff1
    candidate2 := maxDiff2 - minDiff2

    return max(maxVal, max(candidate1, candidate2))
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}