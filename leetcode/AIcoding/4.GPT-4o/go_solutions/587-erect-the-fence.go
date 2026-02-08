package main

import (
    "sort"
)

func outerTrees(points [][]int) [][]int {
    n := len(points)
    if n <= 1 {
        return points
    }

    // Sort the points
    sort.Slice(points, func(i, j int) bool {
        if points[i][0] == points[j][0] {
            return points[i][1] < points[j][1]
        }
        return points[i][0] < points[j][0]
    })

    // Build the lower hull
    lower := [][]int{}
    for _, p := range points {
        for len(lower) >= 2 && cross(lower[len(lower)-2], lower[len(lower)-1], p) <= 0 {
            lower = lower[:len(lower)-1]
        }
        lower = append(lower, p)
    }

    // Build the upper hull
    upper := [][]int{}
    for i := n - 1; i >= 0; i-- {
        p := points[i]
        for len(upper) >= 2 && cross(upper[len(upper)-2], upper[len(upper)-1], p) <= 0 {
            upper = upper[:len(upper)-1]
        }
        upper = append(upper, p)
    }

    // Remove the last point of each half because it's repeated at the beginning of the other half
    upper = upper[1:]
    return append(lower, upper...)
}

func cross(o, a, b []int) int {
    return (a[0]-o[0])*(b[1]-o[1]) - (a[1]-o[1])*(b[0]-o[0])
}