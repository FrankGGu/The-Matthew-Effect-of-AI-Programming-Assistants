package main

func countCoveredBuildings(views []int) int {
    n := len(views)
    if n == 0 {
        return 0
    }

    result := 0
    maxSoFar := 0

    for i := 0; i < n; i++ {
        if views[i] > maxSoFar {
            result++
            maxSoFar = views[i]
        }
    }

    return result
}